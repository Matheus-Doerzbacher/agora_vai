import 'package:agora_vai/domain/model/usuario.dart';

class LoginResponse {
  final String token;
  final Usuario usuario;

  LoginResponse({required this.token, required this.usuario});

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      token: map['token'],
      usuario: Usuario.fromMap(map['user']),
    );
  }
}
