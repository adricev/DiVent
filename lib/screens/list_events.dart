import 'package:flutter/material.dart';

class ListEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Eventos'),
      ),
      body: Center(
        child: Text(
          'Aquí va el listado de eventos',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
