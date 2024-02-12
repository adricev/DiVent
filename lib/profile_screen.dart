import 'dart:developer';
import 'package:divent/home_screen.dart';
import 'package:divent/terms_cons_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'list_events.dart';
import 'new_event.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error al cargar datos del usuario');
        } else if (snapshot.hasData) {
          final userData = snapshot.data as Map<String, dynamic>;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Perfil'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('images/splashLogo.png'),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData['user_name'].toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            userData['user_mail'].toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Navegar a la pantalla de edición del perfil
                            },
                            child: const Text('Editar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Ajustes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    title: const Text('Notificaciones'),
                    trailing: Switch(
                      value: true, // Aquí deberías manejar el estado del switch
                      onChanged: (value) {
                        // Lógica para cambiar el estado de las notificaciones
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Modo Oscuro'),
                    trailing: Switch(
                      value:
                          false, // Aquí deberías manejar el estado del switch
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
                          builder: (context) => TermsAndConditionsScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Términos y Condiciones',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
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
        } else {
          return const Text('No se pudo obtener información del usuario');
        }
      },
    );
  }

  Future<Map<String, dynamic>> getUserData() async {
    final supabase = Supabase.instance.client;

    final response =
        await supabase.from('users').select().eq('id_user', 1).single();
    print(response);
    return {}; // Devolver un mapa vacío si no se pueden obtener datos
  }
}
