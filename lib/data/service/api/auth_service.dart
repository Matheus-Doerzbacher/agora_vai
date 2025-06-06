import 'package:agora_vai/data/service/api/client/api_client.dart';
import 'package:agora_vai/data/service/api/client/auth_api_client.dart';
import 'package:agora_vai/data/service/api/model/auth/login_request.dart';
import 'package:agora_vai/data/service/api/model/auth/login_response.dart';
import 'package:agora_vai/domain/model/usuario.dart';
import 'package:result_dart/result_dart.dart';

import '../../../core/print_custom.dart';

class AuthService {
  final ApiClient _apiClient;
  final AuthApiClient _authApiClient;

  AuthService({
    required ApiClient apiClient,
    required AuthApiClient authApiClient,
  }) : _apiClient = apiClient,
       _authApiClient = authApiClient;

  final _print = PrintCustom('AuthService');

  AsyncResult<LoginResponse> login(LoginRequest loginRequest) {
    return _authApiClient.post(loginRequest);
  }

  AsyncResult<Usuario> me() async {
    try {
      final result = await _apiClient.get('/api/auth/me');

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
}
