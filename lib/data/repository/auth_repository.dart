import 'package:agora_vai/core/print_custom.dart';
import 'package:agora_vai/data/service/api/auth_service.dart';
import 'package:agora_vai/data/service/api/client/api_client.dart';
import 'package:agora_vai/data/service/api/model/auth/login_request.dart';
import 'package:agora_vai/data/service/local/shared_preferences_service.dart';
import 'package:agora_vai/domain/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

const _tokenKey = 'auth_token';

class AuthRepository extends ChangeNotifier {
  final ApiClient _apiClient;
  final AuthService _authService;
  final SharedPreferencesService _sharedPreferencesService;

  AuthRepository({
    required ApiClient apiClient,
    required AuthService authService,
    required SharedPreferencesService sharedPreferencesService,
  }) : _apiClient = apiClient,
       _authService = authService,
       _sharedPreferencesService = sharedPreferencesService {
    _apiClient.authHeaderProvider = _authHeaderProvider;
  }

  Usuario? _usuarioLogado;
  Usuario? get usuarioLogado => _usuarioLogado;

  String? _authToken;

  final _print = PrintCustom('AuthRepository');

  /// Fetch token from shared preferences
  Future<void> _fetch() async {
    try {
      _print
        ..space()
        ..title('Realizando Fetch de Autenticação');

      final token = await _sharedPreferencesService.get(_tokenKey).getOrThrow();
      _authToken = token;

      final usuario = await _authService.me().getOrThrow();
      _usuarioLogado = usuario;
      notifyListeners();
    } catch (e) {
      _print.error('Houve um problema ao realizar Fetch de Autenticação');
    } finally {
      _print
        ..line()
        ..space();
    }
  }

  Future<bool> get isAuthenticated async {
    if (_usuarioLogado != null) {
      return true;
    }
    await _fetch();
    return _usuarioLogado != null;
  }

  AsyncResult<Unit> login(LoginRequest loginRequest) async {
    final result = await _authService.login(loginRequest);
    return await result.fold((loginResponse) async {
      _usuarioLogado = loginResponse.usuario;
      _authToken = loginResponse.token;
      final saveResult = await _sharedPreferencesService.save(
        _tokenKey,
        _authToken!,
      );
      return saveResult.fold((success) {
        notifyListeners();
        return const Success(unit);
      }, Failure.new);
    }, Failure.new);
  }

  AsyncResult<Unit> logout() async {
    _authToken = null;
    _usuarioLogado = null;
    await _sharedPreferencesService.remove(_tokenKey);
    notifyListeners();
    return const Success(unit);
  }

  String? _authHeaderProvider() =>
      _authToken != null ? 'Bearer $_authToken' : null;
}
