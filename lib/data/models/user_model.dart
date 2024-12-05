// Modelo del Usuario
class UserModel {
  final int id;
  final String nombre;
  final String apellido;
  final String username;
  final String password;
  final String email;
  final String authToken;

  UserModel(
      {required this.id,
      required this.nombre,
      required this.apellido,
      required this.username,
      required this.password,
      required this.email,
      required this.authToken});

  // Adapter de json a modelo
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['data']['id'],
        nombre: json['data']['nombre'],
        apellido: json['data']['apellido'],
        username: json['data']['username'],
        password: json['data']['password'],
        email: json['data']['email'],
        authToken: json['data']['authToken']);
  }
}
