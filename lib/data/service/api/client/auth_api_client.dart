import 'dart:convert';

import 'package:agora_vai/core/print_custom.dart';
import 'package:agora_vai/data/service/api/model/auth/login_request.dart';
import 'package:agora_vai/data/service/api/model/auth/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:result_dart/result_dart.dart';

class AuthApiClient {
  final _baseUrl = 'http://localhost:8080';
  final _path = '/api/auth/login';

  final _print = PrintCustom('AuthApiClient');

  Map<String, String> get headers {
    final headers = <String, String>{'Content-Type': 'application/json'};
    return headers;
  }

  AsyncResult<LoginResponse> post(LoginRequest loginRequest) async {
    try {
      _print
        ..space()
        ..title('INICIO DA REQUISIÇÃO DE LOGIN')
        ..info('Path: $_path')
        ..info('Body: ${loginRequest.toMap()}')
        ..info('Headers: $headers');

      final uri = Uri.parse('$_baseUrl$_path');

      _print.info('URI: $uri');

      final response = await http.post(
        uri,
        body: jsonEncode(loginRequest.toMap()),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _print
          ..success('Resposta: ${response.body}')
          ..success('Login realizado com sucesso');

        final loginResponse = LoginResponse.fromMap(jsonDecode(response.body));
        return Success(loginResponse);
      } else {
        _print
          ..error('Falha ao fazer login: ${response.statusCode}')
          ..error('Resposta: ${response.body}');
        return Failure(Exception(response.body));
      }
    } catch (e) {
      _print
        ..error('Erro ao fazer login')
        ..error('Erro: $e');
      return Failure(Exception(e));
    } finally {
      _print
        ..line()
        ..space();
    }
  }
}
