import 'dart:io'; // Importación para manejar operaciones de archivos
import 'package:flutter/material.dart'; // Importación de Flutter Material Design
import 'package:image_picker/image_picker.dart'; // Importación para seleccionar imágenes
import 'profile_screen.dart'; // Importación de la pantalla de perfil

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // Controladores para los campos de texto
  final TextEditingController _newNameController = TextEditingController();
  final TextEditingController _confirmNameController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _newPhoneController = TextEditingController();
  final TextEditingController _confirmPhoneController = TextEditingController();

  File? _image; // Variable para almacenar la imagen seleccionada

  // Método para obtener una imagen de la galería
  Future _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;
    setState(() {
      _image = File(pickedImage.path); // Almacena la imagen seleccionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'), // Título de la barra de aplicación
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sección de imagen de perfil
            _image != null
                ? CircleAvatar(
                    backgroundImage:
                        FileImage(_image!), // Muestra la imagen seleccionada
                    radius: 50.0,
                  )
                : ElevatedButton(
                    onPressed: _getImageFromGallery,
                    child: const Text(
                        'Choose Profile Picture'), // Botón para seleccionar una imagen
                  ),
            const SizedBox(height: 10),

            // Campos de texto
            TextFormField(
              controller: _newNameController,
              decoration: _inputDecoration('Nuevo Nombre'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmNameController,
              decoration: _inputDecoration('Confirmar Nombre'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _newEmailController,
              decoration: _inputDecoration('Nuevo Email'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmEmailController,
              decoration: _inputDecoration('Confirmar Email'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _newPhoneController,
              decoration: _inputDecoration('Nuevo Telefono'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmPhoneController,
              decoration: _inputDecoration('Confirmar Telefono'),
            ),
            const SizedBox(height: 10),

            // Botón para guardar cambios
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de perfil cuando se presiona el botón "Save Changes"
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: const Text('Save Changes'), // Texto del botón
            ),
          ],
        ),
      ),
    );
  }

  // Método para personalizar la apariencia de los campos de texto
  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: const Color(0xFFD8D5FC),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 12.0,
      ),
    );
  }
}
