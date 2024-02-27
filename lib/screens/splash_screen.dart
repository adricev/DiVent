import 'package:divent/functions/shared_preferences_helper.dart';
import 'package:divent/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login.dart'; //importa el archivo de login
import 'register_screen.dart'; // Importa el archivo donde está definida la clase RegisterScreen
import 'message_admin.dart'; // Importa el archivo donde está definida la clase MessageAdmin

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
    Future.delayed(Duration(seconds: 2), () async {
      // Verifica si el usuario ha iniciado sesión
      final isLoggedIn = await PreferencesHelper.getBool('isLoggedIn');

      // Navega a la pantalla adecuada
      Navigator.pushReplacement(
        context,
        isLoggedIn == true
            ? MaterialPageRoute(builder: (context) => HomeScreen())
            : MaterialPageRoute(builder: (context) => WhiteScreen()),
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
                    'Si cuentas con un código de acceso, ingresa para ver el calendario. Sin código, comunícate con el administrador.',
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: ElevatedButton(
              onPressed: () {
                // Navega a la pantalla LoginScreen cuando se presiona el botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    color: Color(0xFF7268DD), // Color morado
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: InkWell(
                    onTap: () {
                      // Navega a la pantalla MessageAdmin cuando se presiona el botón
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MessageAdmin()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'No tengo un código todavía',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF7268DD), // Color morado
                          fontSize: 20.0,
                        ),
                      ),
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
