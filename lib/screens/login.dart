import 'package:divent/functions/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Importa shared_preferences
import 'package:divent/functions/shared_preferences_helper.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                  TextFormField(
                    controller: _emailController,
                    decoration: _inputDecoration('Correo electrónico'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    decoration: _inputDecoration('Contraseña'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
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

  Future<Map<String, dynamic>> _verifyUser(BuildContext context) async {
    final supabase = Supabase.instance.client;
    String rawPassword = _passwordController.text;
    String hashedPassword = _hashPassword(rawPassword);
    Map<String, dynamic>? userData;
    try {
      final response = await supabase
          .from('users')
          .select()
          .eq('user_mail', _emailController.text)
          .eq('user_pwd', hashedPassword)
          .single();
      print(response); // Imprimir la respuesta completa
      final userData = response as Map<String, dynamic>;
      if (response != null) {
        // Guardar los datos del usuario en SharedPreferences
        ObjUser userObj = ObjUser(
            email: _emailController.text.toLowerCase().trim(),
            pwd: hashedPassword);
        await PreferencesHelper.saveUser(userObj, "UserData");
        await PreferencesHelper.saveBool('isLoggedIn', true);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      print(
          'Usuario o contraseña erroneos'); // Aquí va una ventana pop con ese print
    }

    return userData ?? {};
  }

  String _hashPassword(String password) {
    List<int> passwordBytes = utf8.encode(password);
    Digest hashedBytes = sha256.convert(passwordBytes);
    String hashedPassword = hashedBytes.toString();
    print(hashedPassword);
    return hashedPassword;
  }
}
