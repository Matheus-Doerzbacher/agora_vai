import 'package:agora_vai/data/service/api/compromisso_service.dart';
import 'package:agora_vai/data/service/api/model/compromisso/compromisso_created.dart';
import 'package:agora_vai/domain/model/compromisso.dart';
import 'package:result_dart/result_dart.dart';

class CompromissoRepository {
  final CompromissoService _compromiCompromissoService;

  CompromissoRepository({
    required CompromissoService compromiCompromissoService,
  }) : _compromiCompromissoService = compromiCompromissoService;

  AsyncResult<List<Compromisso>> getCompromissos() async {
    return _compromiCompromissoService.getCompromissos();
  }

  AsyncResult<Compromisso> create(CompromissoCreated compromissoCreated) async {
    return _compromiCompromissoService.create(compromissoCreated);
  }

  AsyncResult<Compromisso> update(
    CompromissoCreated compromissoCreated,
    int idCompromisso,
  ) async {
    return _compromiCompromissoService.update(
      compromissoCreated,
      idCompromisso,
    );
  }

  AsyncResult<Unit> delete(int idCompromisso) async {
    return _compromiCompromissoService.delete(idCompromisso);
  }
}
