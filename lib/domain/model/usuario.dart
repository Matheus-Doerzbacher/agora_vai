class Usuario {
  final int idUsuario;
  final String email;
  final String nome;
  final bool isAdmin;

  Usuario({
    required this.idUsuario,
    required this.email,
    required this.nome,
    required this.isAdmin,
  });

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['idUsuario'],
      email: map['email'],
      nome: map['name'],
      isAdmin: map['isAdmin'],
    );
  }
}
