class Usuario {
  final int idUsuario;
  final String email;
  final String name;

  Usuario({required this.idUsuario, required this.email, required this.name});

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['idUsuario'],
      email: map['email'],
      name: map['name'],
    );
  }
}
