import 'dart:convert'; // Importa el paquete necesario para trabajar con codificación y decodificación JSON
import 'package:divent/functions/user.dart'; // Importa la clase ObjUser desde el archivo user.dart
import 'package:shared_preferences/shared_preferences.dart'; // Importa el paquete shared_preferences

class PreferencesHelper {
  // Método estático para guardar la información del usuario en SharedPreferences
  static Future<void> saveUser(ObjUser userObj, String name) async {
    final SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Obtiene una instancia de SharedPreferences
    prefs.setString(
        name,
        jsonEncode(userObj
            .toJson())); // Codifica la información del usuario como JSON y la guarda en SharedPreferences
  }

  // Método estático para obtener la información del usuario desde SharedPreferences
  static Future<ObjUser?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Obtiene una instancia de SharedPreferences
    final String? userString =
        prefs.getString('userData'); // Obtiene la cadena JSON del usuario
    return userString != null
        ? ObjUser.fromJson(jsonDecode(userString))
        : null; // Decodifica la cadena JSON y crea un objeto ObjUser, devuelve null si la cadena es nula
  }

  // Método estático para eliminar la información del usuario de SharedPreferences
  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Obtiene una instancia de SharedPreferences
    prefs.remove(
        'userData'); // Elimina la información del usuario utilizando la clave 'userData'
  }
}
