import 'package:agora_vai/core/print_custom.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final _print = PrintCustom('SharedPreferencesService');

  AsyncResult<String> get(String key) async {
    try {
      _print
        ..space()
        ..title('Buscando dados do SharedPreferences')
        ..info('Key: $key');
      final sharedPreferences = await SharedPreferences.getInstance();
      final result = sharedPreferences.getString(key);

      if (result == null) {
        _print.error('Dados não encontrados');
        return Failure(Exception('Dados não encontrados'));
      }

      _print
        ..success('Dados encontrados')
        ..success('Dados: $result');
      return Success(result);
    } catch (e) {
      _print.error('Houve um problema ao buscar dados do SharedPreferences');
      return Failure(Exception(e));
    } finally {
      _print
        ..line()
        ..space();
    }
  }

  AsyncResult<String> save(String key, String value) async {
    try {
      _print
        ..space()
        ..title('Salvando dados no SharedPreferences')
        ..info('Key: $key')
        ..info('Value: $value');
      final sharedPreferences = await SharedPreferences.getInstance();
      final isSave = await sharedPreferences.setString(key, value);
      if (!isSave) {
        _print.error('Falha ao salvar dados');
        return Failure(Exception('Falha ao salvar dados'));
      }
      _print.success('Dados salvos com sucesso');
      return Success(value);
    } catch (e) {
      _print.error('Houve um problema ao salvar dados no SharedPreferences');
      return Failure(Exception(e));
    } finally {
      _print
        ..line()
        ..space();
    }
  }

  AsyncResult<Unit> remove(String key) async {
    try {
      _print
        ..space()
        ..title('Removendo dados do SharedPreferences')
        ..info('Key: $key');
      final sharedPreferences = await SharedPreferences.getInstance();
      final isRemove = await sharedPreferences.remove(key);
      if (!isRemove) {
        _print.error('Falha ao remover dados');
        return Failure(Exception('Falha ao remover dados'));
      }
      _print.success('Dados removidos com sucesso');
      return const Success(unit);
    } catch (e) {
      _print.error('Houve um problema ao remover dados do SharedPreferences');
      return Failure(Exception(e));
    } finally {
      _print
        ..line()
        ..space();
    }
  }
}
