import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InviteCodeScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();

  InviteCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Código de Invitación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
              validator: (value) {
                // Validar si el correo tiene el formato correcto
                if (!isValidEmail(value!)) {
                  return 'Ingresa un correo electrónico válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmEmailController,
              decoration:
                  InputDecoration(labelText: 'Confirmar Correo electrónico'),
              validator: (value) {
                // Validar si el correo tiene el formato correcto
                if (!isValidEmail(value!)) {
                  return 'Ingresa un correo electrónico válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validar si los correos son iguales
                if (_emailController.text == _confirmEmailController.text) {
                  // Generar código de invitación
                  String codigoInvitacion = _generarCodigoInvitacion();

                  // Mostrar el código al usuario
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Código de Invitación'),
                      content: Text(
                        'Tu código de invitación es: $codigoInvitacion',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Copiar al portapapeles
                            FlutterClipboard.copy(codigoInvitacion)
                                .then((value) => Navigator.pop(context));
                          },
                          child: const Text('Copiar'),
                        ),
                      ],
                    ),
                  );

                  // Subir a la tabla invites
                  _subirInvitacion(codigoInvitacion, _emailController.text);
                } else {
                  // Mostrar mensaje de error si los correos no coinciden
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Los correos no coinciden.'),
                    ),
                  );
                }
              },
              child: const Text('Crear Código de Invitación'),
            ),
          ],
        ),
      ),
    );
  }

  String _generarCodigoInvitacion() {
    // Lógica para generar código aleatorio de 4 letras en mayúscula
    // (puedes personalizar esto según tus necesidades)
    const letras = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String codigo = '';
    for (int i = 0; i < 4; i++) {
      codigo += letras[DateTime.now().microsecond % letras.length];
    }
    return codigo;
  }

  Future<void> _subirInvitacion(String codigo, String email) async {
    final supabase = Supabase.instance.client;

    try {
      // Validar si ya existe un código con el mismo email
      // final existeCodigo = await supabase
      //     .from('invites')
      //     .select()
      //     .eq('invite_code', codigo)
      //     .eq('invite_mail', email);

      // if (existeCodigo.isNotEmpty) {
      //   // Mostrar mensaje de error si ya existe un código con el mismo email
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Ya existe un código de invitación con este correo.'),
      //     ),
      //   );
      //   return;
      // }

      final response = await supabase.from('invites').insert([
        {
          'invite_code': codigo,
          'invite_mail': email,
        }
      ]);

      if (response.error != null) {
        // Manejar el error, por ejemplo, mostrar un mensaje al usuario
        print('Error al subir la invitación: ${response.error!.message}');
      } else {
        // La invitación se ha subido exitosamente
        print('Invitación subida exitosamente.');
      }
    } catch (e) {
      // Manejar cualquier excepción
      print('Error inesperado al subir la invitación: $e');
    }
  }

  bool isValidEmail(String email) {
    // Validar el formato de correo electrónico
    RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
    return emailRegex.hasMatch(email);
  }
}
