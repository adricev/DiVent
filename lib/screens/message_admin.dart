import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'splash_screen.dart'; // Importa el archivo donde está definida la clase SplashScreen

// Pantalla para enviar un mensaje al administrador de la aplicación
class MessageAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logotipo de la aplicación
            Container(
              margin: EdgeInsets.only(
                  bottom:
                      120.0), // Margen inferior para separar la imagen del texto
              child: SvgPicture.asset(
                'images/splashLogo1.svg',
                width: 80.0,
                height: 80.0,
              ),
            ),
            // Texto explicativo
            Text(
              'A continuación podrás mandarle un mensaje al administrador de la aplicación para solicitar un código y acceder a un calendario.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            // Campo de texto para el asunto del mensaje
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Asunto',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFFD8D5FC),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 12.0,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Campo de texto para el cuerpo del mensaje
            TextFormField(
              maxLines: 7,
              decoration: InputDecoration(
                labelText: 'Mensaje',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFFD8D5FC),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 12.0,
                ),
              ),
            ),
            SizedBox(height: 40),
            // Botón para enviar el mensaje
            ElevatedButton(
              onPressed: () {
                // Mostrar un diálogo emergente para confirmar el envío del mensaje
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Mensaje enviado'),
                      content: Text('El mensaje se ha enviado correctamente.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Cierra el diálogo
                            Navigator.of(context).pop();
                            // Navega a la pantalla de Splash
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SplashScreen()),
                            );
                          },
                          child: Text('Aceptar'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF7268DD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Enviar mensaje',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
