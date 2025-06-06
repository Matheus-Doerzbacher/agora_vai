class LembreteCreate {
  final String titulo;
  final String descricao;
  final bool isConcluido;

  LembreteCreate({
    required this.titulo,
    required this.descricao,
    required this.isConcluido,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'isConcluido': isConcluido,
    };
  }
}
