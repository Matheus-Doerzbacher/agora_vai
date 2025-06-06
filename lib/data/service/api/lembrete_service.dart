import 'package:agora_vai/core/print_custom.dart';
import 'package:agora_vai/data/service/api/client/api_client.dart';
import 'package:agora_vai/domain/model/lembrete.dart';
import 'package:result_dart/result_dart.dart';

class LembreteService {
  final ApiClient _apiClient;

  LembreteService({required ApiClient apiClient}) : _apiClient = apiClient;

  final _path = '/api/lembretes';
  final _print = PrintCustom('LembreteService');

  AsyncResult<List<Lembrete>> getLembretes() async {
    try {
      final response = await _apiClient.get(_path);
      return response.fold((success) {
        final lembretes = (success as List)
            .map((e) => Lembrete.fromMap(e as Map<String, dynamic>))
            .toList();
        return Success(lembretes);
      }, Failure.new);
    } catch (e) {
      _print
        ..error('Erro ao montar lista de lembretes')
        ..error('Erro: $e');
      return Failure(Exception(e));
    }
  }
}
