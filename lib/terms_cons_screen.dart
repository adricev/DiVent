import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Términos y Condiciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Términos y Condiciones',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed hendrerit dui id eleifend ultricies. Ut egestas nisi eu ligula eleifend, sit amet fermentum dui vestibulum. Nulla facilisi. Maecenas id arcu in ex rutrum semper a et enim. Phasellus euismod eget lacus vel auctor. Aliquam dapibus ligula nec risus blandit, quis pharetra nulla venenatis. Vivamus sit amet nisi et enim tincidunt sollicitudin. Phasellus et lorem a mauris luctus vehicula. Integer pharetra metus sit amet felis feugiat, nec bibendum nulla bibendum. Nam nec fringilla mauris.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Suspendisse rhoncus leo nisi, quis sodales lectus placerat quis. Morbi viverra turpis id magna congue aliquam. Suspendisse potenti. Integer non libero at ante porttitor fringilla. Aenean porttitor tortor in quam efficitur, non ullamcorper arcu scelerisque. In semper pharetra justo, sed facilisis risus elementum vitae. Proin condimentum malesuada elit, eu aliquet felis mattis eget. Vestibulum rutrum risus eu dui tempor, et placerat est sollicitudin. Vivamus volutpat velit eros, id volutpat neque hendrerit a. Morbi porttitor risus vel felis pellentesque, non elementum ex hendrerit.',
                style: TextStyle(fontSize: 16),
              ),
              // Puedes seguir añadiendo más texto según sea necesario
            ],
          ),
        ),
      ),
    );
  }
}
