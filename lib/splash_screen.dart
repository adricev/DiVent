import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'register_screen.dart'; // Importa el archivo donde está definida la clase Registro

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simula una carga de la aplicación durante 3 segundos
    Future.delayed(Duration(seconds: 3), () {
      // Navegar a la pantalla blanca después de 3 segundos
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WhiteScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF7268DD), // Color en hexadecimal
        child: Center(
          child: Image.asset(
            "images/splashLogo.png", // Ruta de la imagen en los activos
            width: 200, // Ancho deseado de la imagen
            height: 100, // Alto deseado de la imagen
          ),
        ),
      ),
    );
  }
}

class WhiteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 100.0, // Altura del contenedor
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: SvgPicture.asset(
                'images/splashLogo1.svg', // Ruta del archivo SVG en los activos
                width: 100.0, // Ancho deseado de la imagen
                height: 64.0, // Altura deseada de la imagen
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Si alguien te ha mandado el código de acceso podrás acceder a su calendario y consultar sus eventos. Si todavía no tienes un código de acceso tendrás que ponerte en contacto con el administrador.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navega a la pantalla RegisterScreen cuando se presiona el botón
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF7268DD), // Color en hexadecimal
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Tengo un código',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Acciones cuando se presiona el segundo botón
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    'No tengo un código todavía',
                    style: TextStyle(
                      color: Color(0xFF7268DD), // Color en hexadecimal
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
