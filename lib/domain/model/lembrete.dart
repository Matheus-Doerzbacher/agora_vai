class Lembrete {
  final int idLembrete;
  final String titulo;
  final String descricao;
  final DateTime dataCriacao;
  final bool isConcluido;

  Lembrete({
    required this.idLembrete,
    required this.titulo,
    required this.descricao,
    required this.dataCriacao,
    required this.isConcluido,
  });

  factory Lembrete.fromMap(Map<String, dynamic> json) {
    return Lembrete(
      idLembrete: json['idLembrete'] as int,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      dataCriacao: DateTime.parse(json['dataCriacao'] as String),
      isConcluido: json['isConcluido'] as bool,
    );
  }
}
