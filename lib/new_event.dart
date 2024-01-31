import 'package:flutter/material.dart';

class NewEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear un evento'),
      ),
      body: Center(
        child: Text(
          'Aquí se crean los eventos',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
