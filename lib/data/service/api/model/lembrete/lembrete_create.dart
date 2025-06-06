class CreateLembrete {
  final String titulo;
  final String descricao;
  final bool isConcluido;

  CreateLembrete({
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
