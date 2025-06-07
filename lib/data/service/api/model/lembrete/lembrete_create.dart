class CreateLembrete {
  final String titulo;
  final String descricao;
  final DateTime? dataHora;
  final bool isConcluido;

  CreateLembrete({
    required this.titulo,
    required this.descricao,
    this.dataHora,
    this.isConcluido = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'dataHora': dataHora?.toIso8601String(),
      'isConcluido': isConcluido,
    };
  }
}
