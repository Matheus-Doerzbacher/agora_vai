import 'dart:convert';

import 'package:agora_vai/core/print.dart';
import 'package:http/http.dart' as http;
import 'package:result_dart/result_dart.dart';

class ApiClient {
  final _baseUrl = 'http://localhost:8080';

  final _print = PrintCustom('ApiClient');

  AsyncResult<dynamic> get(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    try {
      _print
        ..title('INICIO DA REQUISIÇÃO')
        ..info('GET $path')
        ..info('Query Parameters: $queryParameters');

      var uri = Uri.parse('$_baseUrl$path');

      if (queryParameters != null) {
        uri = uri.replace(queryParameters: queryParameters);
      }

      _print.info('URI: $uri');
      final response = await http.get(uri);
      _print
        ..info('Resposta: ${jsonEncode(response)}')
        ..success('Requisição finalizada com sucesso');
      return Success(response.body);
    } on Exception catch (e) {
      _print
        ..error('Erro ao fazer a requisição')
        ..error('Erro: $e');
      return Failure(e);
    } finally {
      _print.line();
    }
  }
}
