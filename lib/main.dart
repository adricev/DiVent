import 'package:flutter/material.dart';
import 'package:divent/splash_screen.dart'; // Asegúrate de que la ruta de importación sea correcta

void main() {
  runApp(MainApp()); //Hola mundo
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key); // Corregido el constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          SplashScreen(), // Utiliza SplashScreen() para referirte a la pantalla de splash
    );
  }
}
