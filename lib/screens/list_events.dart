import 'package:flutter/material.dart';

class ListEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Eventos'), // Título de la AppBar
      ),
      body: Center(
        child: Text(
          'Aquí va el listado de eventos', // Texto en el centro del cuerpo
          style: TextStyle(fontSize: 20), // Estilo del texto
        ),
      ),
    );
  }
}
