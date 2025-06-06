import 'package:agora_vai/data/service/api/lembrete_service.dart';
import 'package:agora_vai/domain/model/lembrete.dart';
import 'package:result_dart/result_dart.dart';

class LembreteRepository {
  final LembreteService _lembreteService;

  LembreteRepository({required LembreteService lembreteService})
    : _lembreteService = lembreteService;

  AsyncResult<List<Lembrete>> getLembretes() async {
    return _lembreteService.getLembretes();
  }
}
