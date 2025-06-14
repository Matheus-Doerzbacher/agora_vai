// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:agora_vai/core/config/api_config.dart';
import 'package:agora_vai/core/print_custom.dart';
import 'package:http/http.dart' as http;
import 'package:result_dart/result_dart.dart';

typedef AuthHeaderProvider = String? Function();

class ApiClient {
  AuthHeaderProvider? authHeaderProvider;
  final _baseUrl = ApiConfig.baseUrl;

  final _print = PrintCustom('ApiClient');

  Map<String, String> get headers {
    final headers = <String, String>{'Content-Type': 'application/json'};

    if (authHeaderProvider != null) {
      final authHeader = authHeaderProvider!.call();
      if (authHeader != null) {
        headers['Authorization'] = authHeader;
      }
    }

    // headers['Authorization'] =
    //     'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJtYXRoZXVzLmRvZXJAZ21haWwuY29tIiwiaWF0IjoxNzQ5MTcwMzkyLCJleHAiOjE3NDkyNTY3OTJ9.gybeDRWkQjycEh-4aUEhOGxIsyBMXqT2YPReOPChedrrVx6WDQgt0OEQ4qNH0FZJ8q2qBnl4FaJJPycOmafRZQ';
    return headers;
  }

  AsyncResult<dynamic> get(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    try {
      _print
        ..title('INICIO DA REQUISIÇÃO GET')
        ..info('Path: $path')
        ..info('Query Parameters: $queryParameters')
        ..info('Headers: $headers');

      var uri = Uri.parse('$_baseUrl$path');
      if (queryParameters != null) {
        uri = uri.replace(queryParameters: queryParameters);
      }
      _print.info('URI: $uri');
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        _print
          ..success('Resposta: ${response.body}')
          ..success('Requisição GET $path finalizada com sucesso');
        return Success(jsonDecode(response.body));
      } else {
        _print
          ..error(
            'Requisição GET $path finalizada com erro: ${response.statusCode}',
          )
          ..error('Resposta: ${response.body}');
        return Failure(Exception(response.body));
      }
    } on Exception catch (e) {
      _print
        ..error('Erro ao fazer a requisição GET $path')
        ..error('Erro: $e');
      return Failure(e);
    } finally {
      _print.line();
    }
  }

  AsyncResult<dynamic> post(String path, {Map<String, dynamic>? body}) async {
    try {
      _print
        ..title('INICIO DA REQUISIÇÃO POST')
        ..info('Path: $path')
        ..info('Body: $body')
        ..info('Headers: $headers');

      final uri = Uri.parse('$_baseUrl$path');

      _print.info('URI: $uri');

      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _print
          ..success('Resposta: ${response.body}')
          ..success('Requisição POST $path finalizada com sucesso');
        return Success(jsonDecode(response.body));
      } else {
        _print
          ..error(
            'Requisição POST $path finalizada com erro: ${response.statusCode}',
          )
          ..error('Resposta: ${response.body}');
        return Failure(Exception(response.body));
      }
    } on Exception catch (e) {
      _print
        ..error('Erro ao fazer a requisição POST $path')
        ..error('Erro: $e');
      return Failure(e);
    } finally {
      _print.line();
    }
  }

  AsyncResult<dynamic> put(
    String path, {
    required Map<String, dynamic> body,
    required int id,
  }) async {
    try {
      _print
        ..title('INICIO DA REQUISIÇÃO PUT')
        ..info('Path: $path/$id')
        ..info('Body: $body')
        ..info('Headers: $headers');

      final uri = Uri.parse('$_baseUrl$path/$id');

      _print.info('URI: $uri');

      final response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _print
          ..success('Resposta: ${response.body}')
          ..success('Requisição PUT $path/$id finalizada com sucesso');
        return Success(jsonDecode(response.body));
      } else {
        _print
          ..error(
            'Requisição PUT $path/$id finalizada com erro: ${response.statusCode}',
          )
          ..error('Resposta: ${response.body}');
        return Failure(Exception(response.body));
      }
    } on Exception catch (e) {
      _print
        ..error('Erro ao fazer a requisição PUT $path/$id')
        ..error('Erro: $e');
      return Failure(e);
    } finally {
      _print.line();
    }
  }

  AsyncResult<Unit> delete(String path, {required int id}) async {
    try {
      _print
        ..title('INICIO DA REQUISIÇÃO DELETE')
        ..info('Path: $path/$id')
        ..info('Headers: $headers');

      final uri = Uri.parse('$_baseUrl$path/$id');
      _print.info('URI: $uri');
      final response = await http.delete(uri, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 204) {
        _print
          ..success('Resposta: ${response.body}')
          ..success('Requisição DELETE $path/$id finalizada com sucesso');
        return const Success(unit);
      } else {
        _print
          ..error(
            'Requisição DELETE $path/$id finalizada com erro: ${response.statusCode}',
          )
          ..error('Resposta: ${response.body}');
        return Failure(Exception(response.body));
      }
    } on Exception catch (e) {
      _print
        ..error('Erro ao fazer a requisição DELETE $path/$id')
        ..error('Erro: $e');
      return Failure(e);
    } finally {
      _print.line();
    }
  }
}
