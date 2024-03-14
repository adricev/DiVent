import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Términos y Condiciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Términos y Condiciones',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                '¡Bienvenido a nuestra aplicación! Antes de comenzar a utilizarla, por favor, tómate un momento para revisar estos términos y condiciones.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Al utilizar nuestra aplicación, aceptas los siguientes términos y condiciones:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '1. Responsabilidad del usuario: Eres responsable de cualquier acción que realices en nuestra aplicación y del contenido que publiques.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '2. Privacidad: Respetamos tu privacidad y protegemos tus datos personales de acuerdo con nuestra política de privacidad.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '3. Uso aceptable: No uses nuestra aplicación de manera que pueda dañarla, impedir su funcionamiento normal o afectar negativamente a otros usuarios.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Estos son solo algunos de los términos y condiciones importantes. Por favor, revisa la versión completa en nuestra aplicación antes de continuar.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
