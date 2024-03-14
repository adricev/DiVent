class ObjUser {
  String email; // Correo electrónico del usuario
  String pwd; // Contraseña del usuario

  ObjUser(
      {required this.email,
      required this.pwd}); // Constructor de la clase ObjUser

  // Método de fábrica para crear una instancia de ObjUser desde un mapa (json)
  factory ObjUser.fromJson(Map<String, dynamic> json) {
    return ObjUser(
      email: json['email'], // Obtiene el correo electrónico del mapa json
      pwd: json['pwd'], // Obtiene la contraseña del mapa json
    );
  }

  // Método para convertir ObjUser a un mapa (json)
  Map<String, dynamic> toJson() {
    return {
      'email': email, // Agrega el correo electrónico al mapa json
      'pwd': pwd, // Agrega la contraseña al mapa json
    };
  }
}
