class UsuarioCreate {
  final String nome;
  final String email;
  final String senha;

  UsuarioCreate({required this.nome, required this.email, required this.senha});

  Map<String, dynamic> toMap() {
    return {'nome': nome, 'email': email, 'senha': senha};
  }
}
