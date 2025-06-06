class Compromisso {
  final int idCompromisso;
  final String titulo;
  final String descricao;
  final DateTime dataHoraInicio;
  final DateTime dataHoraFim;
  final String local;

  Compromisso({
    required this.idCompromisso,
    required this.titulo,
    required this.descricao,
    required this.dataHoraInicio,
    required this.dataHoraFim,
    required this.local,
  });

  factory Compromisso.fromMap(Map<String, dynamic> json) {
    return Compromisso(
      idCompromisso: json['idCompromisso'] as int,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      dataHoraInicio: DateTime.parse(json['dataHoraInicio'] as String),
      dataHoraFim: DateTime.parse(json['dataHoraFim'] as String),
      local: json['local'] as String,
    );
  }
}
