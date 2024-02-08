import 'package:divent/home_screen.dart';
import 'package:divent/terms_cons_screen.dart';
import 'package:flutter/material.dart';
import 'list_events.dart';
import 'new_event.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile_picture.jpg'),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre de Usuario',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'correo@dominio.com',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Navegar a la pantalla de edición del perfil
                      },
                      child: Text('Editar'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Ajustes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Notificaciones'),
              trailing: Switch(
                value: true, // Aquí deberías manejar el estado del switch
                onChanged: (value) {
                  // Lógica para cambiar el estado de las notificaciones
                },
              ),
            ),
            ListTile(
              title: Text('Modo Oscuro'),
              trailing: Switch(
                value: false, // Aquí deberías manejar el estado del switch
                onChanged: (value) {
                  // Lógica para cambiar el estado del modo oscuro
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TermsAndConditionsScreen()),
                );
              },
              child: Text(
                'Términos y Condiciones',
                style: TextStyle(
                  fontSize: 16,
                  color:
                      Colors.blue, // Color azul para indicar que es un enlace
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Image.asset('images/Calendar.png', width: 35),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: Image.asset('images/Menu.png', width: 35),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListEvents()),
                );
              },
            ),
            IconButton(
              icon: Image.asset('images/Nuevo.png', width: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewEvent()),
                );
              },
            ),
            IconButton(
              icon: Image.asset('images/B Perfil.png', width: 30),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
