import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _newNameController = TextEditingController();
  final TextEditingController _confirmNameController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _newPhoneController = TextEditingController();
  final TextEditingController _confirmPhoneController = TextEditingController();

  File? _image;

  Future _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile picture section (assuming you want one)
            _image != null
                ? CircleAvatar(
                    backgroundImage: FileImage(_image!),
                    radius: 50.0,
                  )
                : ElevatedButton(
                    onPressed: _getImageFromGallery,
                    child: const Text('Choose Profile Picture'),
                  ),
            const SizedBox(height: 10),

            // Text form fields
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

            ElevatedButton(
              onPressed: () {
                // Navigate to profile screen when Save Changes button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

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
