import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatelessWidget {
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
              SizedBox(height: 20),
              Text(
                'Estás muy cerca de crear tu cuenta, sólo debes rellenar los siguientes campos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: _inputDecoration('Nombre'),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: _inputDecoration('Apellidos'),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: _inputDecoration('Correo electrónico'),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: _inputDecoration('Teléfono'),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: _inputDecoration('Código de invitación'),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: _inputDecoration('Contraseña'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Acciones cuando se presiona el botón
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF7268DD), // Color en hexadecimal
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  'Enviar solicitud',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(height: 20),
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
      fillColor: Color(0xFFD8D5FC), // Color de fondo en hexadecimal
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 12.0,
      ), // Ajustar el padding interior
    );
  }
}
