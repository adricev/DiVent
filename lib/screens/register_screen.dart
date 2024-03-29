import 'package:divent/functions/shared_preferences_helper.dart';
import 'package:divent/functions/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart'; // Importa la pantalla HomeScreen
import 'package:crypto/crypto.dart';
import 'dart:convert'; // Necesario para convertir el hash a String

// Pantalla de registro de usuario
class RegisterScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _invitationCodeController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100.0,
                child: Center(
                  child: SvgPicture.asset(
                    'images/splashLogo1.svg',
                    width: 80.0,
                    height: 80.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Estás muy cerca de crear tu cuenta, sólo debes rellenar los siguientes campos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('Nombre'),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: _inputDecoration('Correo electrónico'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: _inputDecoration('Teléfono'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _invitationCodeController,
                decoration: _inputDecoration('Código de invitación'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: _inputDecoration('Contraseña'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await _saveUser(
                      context); // Guarda el usuario cuando se presiona el botón
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF7268DD), // Color en hexadecimal
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
    );
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), // Radio del borde
        borderSide: BorderSide.none, // Quitar el borde visible
      ),
      filled: true,
      fillColor: const Color(0xFFD8D5FC), // Color de fondo en hexadecimal
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 12.0,
      ), // Ajustar el padding interior
    );
  }

  // Función para guardar los datos del usuario en la base de datos
  Future<Map<String, dynamic>> _saveUser(BuildContext context) async {
    final supabase = Supabase.instance.client;
    Map<String, dynamic>? userData;

    // Obtén la contraseña del controlador
    String rawPassword = _passwordController.text;
    // Aplica el hash a la contraseña
    String hashedPassword = _hashPassword(rawPassword);

    try {
      // Verifica si el código de invitación y el correo electrónico existen
      final inviteCode = await supabase
          .from('invites')
          .select()
          .eq('invite_code', _invitationCodeController.text.trim())
          .eq('invite_mail', _emailController.text.toLowerCase().trim())
          .single();

      final compairEmail = await supabase
          .from('users')
          .select()
          .eq('user_mail', _emailController.text.toLowerCase().trim());

      if (inviteCode != false && compairEmail.isEmpty) {
        // Si el código de invitación existe y el correo electrónico no está registrado
        final response = await supabase.from('users').insert([
          {
            'user_name': _nameController.text.toLowerCase().trim(),
            'user_mail': _emailController.text.toLowerCase().trim(),
            'user_pwd': hashedPassword,
            'user_number': _phoneController.text.trim(),
            'invite_id': inviteCode["id_invite"],
            'user_pic':
                'https://secxumjiywgzbfdwafsc.supabase.co/storage/v1/object/public/profilePic/default.png'
          }
        ]);

        // Crea un objeto de usuario
        ObjUser userObj = ObjUser(
            email: _emailController.text.toLowerCase().trim(),
            pwd: hashedPassword);

        // Guarda el usuario en las preferencias compartidas
        await PreferencesHelper.saveUser(userObj, "userData");

        // Navega a la pantalla HomeScreen después de un registro exitoso
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        print('Email Existente');
      }
    } catch (e) {
      print('Error al procesar la invitación: $e');
    }

    return userData ?? {};
  }

  // Función para aplicar hash a la contraseña
  String _hashPassword(String password) {
    // Convierte la contraseña en bytes
    List<int> passwordBytes = utf8.encode(password);
    // Aplica el hash SHA-256
    Digest hashedBytes = sha256.convert(passwordBytes);
    // Convierte el hash a formato hexadecimal
    String hashedPassword = hashedBytes.toString();
    return hashedPassword;
  }
}
