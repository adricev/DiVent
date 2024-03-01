import 'package:divent/functions/shared_preferences_helper.dart';
import 'package:divent/screens/edit_profile.dart';
import 'package:divent/screens/home_screen.dart';
import 'package:divent/screens/invite_code_screen.dart';
import 'package:divent/screens/splash_screen.dart';
import 'package:divent/screens/terms_cons_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'list_events.dart';
import 'new_event.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error al cargar datos del usuario');
        } else if (snapshot.hasData) {
          final userData = snapshot.data!;
          final pic_string = userData[0]['user_pic'].toString();

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
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(pic_string),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            capitalize(userData[0]['user_name'].toString()),
                            style: const TextStyle(fontSize: 25),
                          ),
                          Text(
                            userData[0]['user_mail'].toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Navegar a la pantalla de edición del perfil
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditProfile()),
                              );
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
                  if (userData[0]['user_privilege'].toString() == 'SuAdmin')
                    ListTile(
                      title: const Text('Generar Código de Invitación'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InviteCodeScreen()),
                        );
                      },
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
                  const Spacer(), // Añadimos un espacio flexible para centrar el botón en la parte inferior
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 8), // Ajustar el padding horizontal
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 220,
                            220), // Color de fondo un poco más oscuro
                        borderRadius: BorderRadius.circular(
                            40), // Ajustar el radio de borde para que se adapte al texto
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          await PreferencesHelper.removeUser();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplashScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Cerrar Sesión',
                          style: TextStyle(
                            color: Colors.red, // Color de texto rojo
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.transparent, // Color de fondo transparente
                          elevation: 0, // Sin sombra
                        ),
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

  Future<List<Map<String, dynamic>>> getUserData() async {
    final supabase = Supabase.instance.client;
    final setUser = await PreferencesHelper.getUser();
    final response = await supabase
        .from('users')
        .select()
        .eq('user_mail', /*'atik@divent.com'*/ setUser?.email as Object);
    return response; // Devolver un mapa vacío si no se pueden obtener datos
  }

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }
}
