import 'package:agora_vai/core/print_custom.dart';
import 'package:agora_vai/data/service/api/client/api_client.dart';
import 'package:agora_vai/data/service/api/model/usuario/usuario_create.dart';
import 'package:agora_vai/domain/model/usuario.dart';
import 'package:result_dart/result_dart.dart';

const String _path = '/api/user';

class UsuarioService {
  final ApiClient _apiClient;

  UsuarioService({required ApiClient apiClient}) : _apiClient = apiClient;

  final _print = PrintCustom('UsuarioService');

  AsyncResult<Usuario> create(UsuarioCreate usuario) async {
    try {
      final result = await _apiClient.post(_path, body: usuario.toMap());

      return result.fold(
        (success) {
          final usuario = Usuario.fromMap(success);
          return Success(usuario);
        },
        (error) {
          return Failure(error);
        },
      );
    } catch (e) {
      _print.error('Erro ao montar usuário: $e');
      return Failure(Exception(e));
    }
  }

  AsyncResult<List<Usuario>> getAll() async {
    try {
      final result = await _apiClient.get(_path);
      return result.fold(
        (success) {
          final usuarios = success.map((e) => Usuario.fromMap(e)).toList();
          return Success(usuarios);
        },
        (error) {
          return Failure(error);
        },
      );
    } catch (e) {
      _print.error('Erro ao montar usuário: $e');
      return Failure(Exception(e));
    }
  }

  AsyncResult<Unit> delete(int idUsuario) async {
    try {
      final result = await _apiClient.delete(_path, id: idUsuario);
      return result.fold((success) => const Success(unit), Failure.new);
    } catch (e) {
      _print.error('Erro ao deletar usuário: $e');
      return Failure(Exception(e));
    }
  }
}
