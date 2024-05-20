import 'package:divent/functions/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:divent/functions/shared_preferences_helper.dart';

// Pantalla de inicio de sesión
class LoginScreen extends StatelessWidget {
  // Controladores de texto para los campos de correo electrónico y contraseña
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Constructor
  LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logotipo de la aplicación
          SizedBox(
            height: 200.0,
            child: Center(
              child: SvgPicture.asset(
                'images/splashLogo1.svg',
                width: 80.0,
                height: 80.0,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Campo de texto para el correo electrónico
                  TextFormField(
                    controller: _emailController,
                    decoration: _inputDecoration('Correo electrónico'),
                  ),
                  const SizedBox(height: 10),
                  // Campo de texto para la contraseña
                  TextFormField(
                    controller: _passwordController,
                    decoration: _inputDecoration('Contraseña'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  // Botón para enviar la solicitud de inicio de sesión
                  ElevatedButton(
                    onPressed: () async {
                      // Verificar al usuario
                      await _verifyUser(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7268DD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    child: const Text(
                      'Enviar solicitud',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Estilo de los campos de texto
  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: const Color(0xFFD8D5FC),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 12.0,
      ),
    );
  }

  // Verificar las credenciales del usuario
  Future<void> _verifyUser(BuildContext context) async {
    final supabase = Supabase.instance.client;
    String rawPassword = _passwordController.text;
    String hashedPassword = _hashPassword(rawPassword);
    String emailController = _emailController.text.toLowerCase().trim();
    Map<String, dynamic>? userData;
    try {
      // Realizar una consulta a la base de datos para verificar las credenciales del usuario
      final response = await supabase
          .from('users')
          .select()
          .eq('user_mail', emailController)
          .eq('user_pwd', hashedPassword)
          .single();

      // Si las credenciales son válidas, guardar los datos del usuario y navegar a la pantalla HomeScreen
      if (response != null) {
        ObjUser userObj = ObjUser(email: emailController, pwd: hashedPassword);
        await PreferencesHelper.saveUser(userObj, "userData");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      // Manejar errores de autenticación
      print('Usuario o contraseña incorrectos');
    }
  }

  // Convertir la contraseña en un hash
  String _hashPassword(String password) {
    List<int> passwordBytes = utf8.encode(password);
    Digest hashedBytes = sha256.convert(passwordBytes);
    String hashedPassword = hashedBytes.toString();
    return hashedPassword;
  }
}
