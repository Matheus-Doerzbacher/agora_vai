import 'package:agora_vai/core/print_custom.dart';
import 'package:agora_vai/data/service/api/client/api_client.dart';
import 'package:agora_vai/data/service/api/model/compromisso/compromisso_created.dart';
import 'package:agora_vai/domain/model/compromisso.dart';
import 'package:result_dart/result_dart.dart';

class CompromissoService {
  final ApiClient _apiClient;

  CompromissoService({required ApiClient apiClient}) : _apiClient = apiClient;

  final _path = '/api/compromissos';
  final _print = PrintCustom('CompromissoService');

  AsyncResult<List<Compromisso>> getCompromissos() async {
    try {
      final response = await _apiClient.get(_path);
      return response.fold((success) {
        final compromissos = (success as List)
            .map((e) => Compromisso.fromMap(e as Map<String, dynamic>))
            .toList();
        return Success(compromissos);
      }, Failure.new);
    } catch (e) {
      _print
        ..error('Erro ao montar lista de compromissos')
        ..error('Erro: $e');
      return Failure(Exception(e));
    }
  }

  AsyncResult<Compromisso> create(CompromissoCreated createLembrete) async {
    try {
      final response = await _apiClient.post(
        _path,
        body: createLembrete.toMap(),
      );
      return response.fold((success) {
        return Success(Compromisso.fromMap(success as Map<String, dynamic>));
      }, Failure.new);
    } catch (e) {
      _print
        ..error('Erro ao criar compromisso')
        ..error('Erro: $e');
      return Failure(Exception(e));
    }
  }

  AsyncResult<Compromisso> update(
    CompromissoCreated createLembrete,
    int idLembrete,
  ) async {
    try {
      final response = await _apiClient.put(
        _path,
        body: createLembrete.toMap(),
        id: idLembrete,
      );
      return response.fold((success) {
        return Success(Compromisso.fromMap(success as Map<String, dynamic>));
      }, Failure.new);
    } catch (e) {
      _print
        ..error('Erro ao editar compromisso')
        ..error('Erro: $e');
      return Failure(Exception(e));
    }
  }

  AsyncResult<Unit> delete(int idCompromisso) {
    return _apiClient.delete(_path, id: idCompromisso);
  }
}
