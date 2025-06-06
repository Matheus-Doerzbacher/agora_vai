class CompromissoCreated {
  final String titulo;
  final String descricao;
  final DateTime dataHoraInicio;
  final DateTime dataHoraFim;
  final String local;

  CompromissoCreated({
    required this.titulo,
    required this.descricao,
    required this.dataHoraInicio,
    required this.dataHoraFim,
    required this.local,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'dataHoraInicio': dataHoraInicio.toIso8601String(),
      'dataHoraFim': dataHoraFim.toIso8601String(),
      'local': local,
    };
  }
}
