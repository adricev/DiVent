import 'package:flutter/material.dart';
import 'package:divent/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Asegúrate de que la ruta de importación sea correcta

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://secxumjiywgzbfdwafsc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlY3h1bWppeXdnemJmZHdhZnNjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY1MDc4MjgsImV4cCI6MjAxMjA4MzgyOH0.wJUWAsPsIVZoba2OSRAPXUJmexJRjz0t7dSyyxPPDmw',
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key); // Corregido el constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
