import 'package:divent/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'list_events.dart';
import 'new_event.dart';
import 'edit_profile.dart';
import 'invite_code_screen.dart';
import 'splash_screen.dart';
import 'terms_cons_screen.dart';
import 'package:divent/functions/shared_preferences_helper.dart';

// Pantalla de perfil del usuario
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getUserData(), // Obtiene los datos del usuario
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
        } else if (snapshot.hasError) {
          return const Text(
              'Error al cargar datos del usuario'); // Muestra un mensaje de error si hay un error al cargar los datos
        } else if (snapshot.hasData) {
          final userData = snapshot.data!;
          final pic_string = userData[0]['user_pic'].toString();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Perfil'), // Barra de título
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Información del usuario
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
                            capitalize(userData[0]['user_name']
                                .toString()), // Nombre de usuario
                            style: const TextStyle(fontSize: 25),
                          ),
                          Text(
                            userData[0]['user_mail']
                                .toString(), // Correo electrónico del usuario
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
                            child: const Text(
                                'Editar'), // Botón para editar el perfil
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
                  // Configuraciones del usuario
                  ListTile(
                    title: const Text('Notificaciones'),
                    trailing: Switch(
                      value:
                          true, // Estado de las notificaciones (debería ser dinámico)
                      onChanged: (value) {
                        // Lógica para cambiar el estado de las notificaciones
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Modo Oscuro'),
                    trailing: Switch(
                      value:
                          false, // Estado del modo oscuro (debería ser dinámico)
                      onChanged: (value) {
                        // Lógica para cambiar el estado del modo oscuro
                      },
                    ),
                  ),
                  // Opción para generar código de invitación (solo para usuarios con privilegio 'SuAdmin')
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
                  // Términos y condiciones
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
                  const Spacer(), // Espacio flexible para centrar el botón en la parte inferior
                  // Botón para cerrar sesión
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
                          await PreferencesHelper
                              .removeUser(); // Eliminar datos de usuario al cerrar sesión
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
            // Barra de navegación inferior
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
          return const Text(
              'No se pudo obtener información del usuario'); // Mensaje si no se pueden obtener datos del usuario
        }
      },
    );
  }

  // Función para obtener los datos del usuario desde la base de datos
  Future<List<Map<String, dynamic>>> getUserData() async {
    final supabase = Supabase.instance.client;
    final setUser = await PreferencesHelper.getUser();
    final response = await supabase
        .from('users')
        .select()
        .eq('user_mail', /*'atik@divent.com'*/ setUser?.email as Object);
    return response; // Devolver un mapa vacío si no se pueden obtener datos
  }

  // Función para capitalizar la primera letra de una cadena
  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }
}
