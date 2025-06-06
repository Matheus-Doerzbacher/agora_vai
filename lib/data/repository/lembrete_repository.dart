import 'package:agora_vai/data/service/api/lembrete_service.dart';
import 'package:agora_vai/data/service/api/model/lembrete/lembrete_create.dart';
import 'package:agora_vai/domain/model/lembrete.dart';
import 'package:result_dart/result_dart.dart';

class LembreteRepository {
  final LembreteService _lembreteService;

  LembreteRepository({required LembreteService lembreteService})
    : _lembreteService = lembreteService;

  AsyncResult<List<Lembrete>> getLembretes() async {
    return _lembreteService.getLembretes();
  }

  AsyncResult<Lembrete> create(CreateLembrete createLembrete) async {
    return _lembreteService.create(createLembrete);
  }

  AsyncResult<Lembrete> update(
    CreateLembrete createLembrete,
    int idLembrete,
  ) async {
    return _lembreteService.update(createLembrete, idLembrete);
  }

  AsyncResult<Unit> delete(int idLembrete) async {
    return _lembreteService.delete(idLembrete);
  }
}
