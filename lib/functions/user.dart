class ObjUser {
  String email;
  String pwd;

  ObjUser({required this.email, required this.pwd});

  // Método de fábrica para crear una instancia de ObjUser desde un mapa (json)
  factory ObjUser.fromJson(Map<String, dynamic> json) {
    return ObjUser(
      email: json['email'],
      pwd: json['pwd'],
    );
  }

  // Método para convertir ObjUser a un mapa (json)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'pwd': pwd,
    };
  }
}
