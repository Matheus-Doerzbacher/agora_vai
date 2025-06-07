class Lembrete {
  final int idLembrete;
  final String titulo;
  final String descricao;
  final DateTime? dataHora;
  final bool isConcluido;

  Lembrete({
    required this.idLembrete,
    required this.titulo,
    required this.descricao,
    this.dataHora,
    required this.isConcluido,
  });

  factory Lembrete.fromMap(Map<String, dynamic> json) {
    return Lembrete(
      idLembrete: json['idLembrete'] as int,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      dataHora: json['dataHora'] != null
          ? DateTime.parse(json['dataHora'] as String)
          : null,
      isConcluido: json['isConcluido'] as bool,
    );
  }
}
