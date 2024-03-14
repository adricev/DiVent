// Importa los paquetes necesarios
import 'package:flutter/material.dart';
import 'package:divent/screens/splash_screen.dart'; // Importa la pantalla de SplashScreen
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Asegura que los Widgets de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Supabase con la URL y la clave anónima
  await Supabase.initialize(
    url: 'https://secxumjiywgzbfdwafsc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlY3h1bWppeXdnemJmZHdhZnNjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY1MDc4MjgsImV4cCI6MjAxMjA4MzgyOH0.wJUWAsPsIVZoba2OSRAPXUJmexJRjz0t7dSyyxPPDmw',
  );

  // Ejecuta la aplicación principal
  runApp(MainApp());
}

// Define la aplicación principal como un StatelessWidget
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key); // Define el constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // Establece la pantalla de inicio como SplashScreen
    );
  }
}
