import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil y configuración'),
      ),
      body: Center(
        child: Text(
          'Aquí van los ajustes y perfil personal',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
