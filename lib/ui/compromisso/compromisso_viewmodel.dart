import 'dart:async';

import 'package:agora_vai/core/compara_datas.dart';
import 'package:agora_vai/core/print_custom.dart';
import 'package:agora_vai/data/repository/auth_repository.dart';
import 'package:agora_vai/data/repository/compromisso_repository.dart';
import 'package:agora_vai/data/repository/noti_repository.dart';
import 'package:agora_vai/data/service/api/model/compromisso/compromisso_created.dart';
import 'package:agora_vai/domain/model/compromisso.dart';
import 'package:agora_vai/domain/model/notificacao.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class CompromissoViewModel extends ChangeNotifier {
  final CompromissoRepository _compromissoRepository;
  final AuthRepository _authRepository;
  final NotiRepository _notiRepository;

  CompromissoViewModel({
    required CompromissoRepository compromissoRepository,
    required AuthRepository authRepository,
    required NotiRepository notiRepository,
  }) : _compromissoRepository = compromissoRepository,
       _authRepository = authRepository,
       _notiRepository = notiRepository {
    _authRepository.addListener(_onAuthStateChanged);
    getCompromissos.execute();
    _iniciarVerificacaoCompromissos();
  }

  final _print = PrintCustom('CompromissoViewModel');

  Timer? _timer;
  void _iniciarVerificacaoCompromissos() {
    _timer?.cancel();

    // Calcula o tempo até o próximo minuto
    final now = DateTime.now();
    final nextMinute = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute + 1,
      1, // Força o segundo 1
    );
    final delay = nextMinute.difference(now);

    // Agenda o primeiro timer para começar no próximo minuto
    Future.delayed(delay, () {
      _verificarCompromissos();

      // Depois inicia o timer periódico
      _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        _verificarCompromissos();
      });
    });
  }

  Future<void> _verificarCompromissos() async {
    _print
      ..title('Iniciando verificação de compromissos')
      ..info('Hora atual: ${DateTime.now()}');

    for (final compromisso in _compromissos) {
      if (comparaDatas(DateTime.now(), compromisso.dataHoraInicio)) {
        _print
          ..success('Compromisso encontrado')
          ..success('Compromisso: ${compromisso.descricao}');
        await _notiRepository.showNotification(
          Notificacao(
            id: compromisso.idCompromisso,
            title: compromisso.titulo,
            body: compromisso.descricao,
          ),
        );
      }
    }
    _print
      ..info('Verificação de compromissos finalizada')
      ..line();
  }

  late final createCompromisso = Command1(_createCompromisso);
  late final getCompromissos = Command0(_getCompromissos);
  late final deleteCompromisso = Command1(_deleteCompromisso);
  late final updateCompromisso = Command2(_updateCompromisso);

  List<Compromisso> _compromissos = [];
  List<Compromisso> get compromissos => _compromissos;

  AsyncResult<Unit> _createCompromisso(
    CompromissoCreated compromissoCreated,
  ) async {
    final result = await _compromissoRepository.create(compromissoCreated);

    return result.fold(
      (compromisso) {
        _compromissos.add(compromisso);
        notifyListeners();
        return const Success(unit);
      },
      (failure) {
        return Failure(failure);
      },
    );
  }

  AsyncResult<List<Compromisso>> _getCompromissos() async {
    final result = await _compromissoRepository.getCompromissos();

    result.fold(
      (compromissos) {
        _compromissos = compromissos;
        notifyListeners();
      },
      (failure) {
        return Failure(failure);
      },
    );

    return result;
  }

  AsyncResult<Unit> _updateCompromisso(
    CompromissoCreated compromissoCreated,
    int idCompromisso,
  ) async {
    final result = await _compromissoRepository.update(
      compromissoCreated,
      idCompromisso,
    );

    return result.fold(
      (compromisso) {
        final index = _compromissos.indexWhere(
          (compromisso) => compromisso.idCompromisso == idCompromisso,
        );
        _compromissos[index] = compromisso;
        notifyListeners();
        return const Success(unit);
      },
      (failure) {
        return Failure(failure);
      },
    );
  }

  AsyncResult<Unit> _deleteCompromisso(int idCompromisso) async {
    final result = await _compromissoRepository.delete(idCompromisso);

    return result.fold(
      (success) {
        _compromissos.removeWhere(
          (compromisso) => compromisso.idCompromisso == idCompromisso,
        );
        notifyListeners();
        return const Success(unit);
      },
      (failure) {
        return Failure(failure);
      },
    );
  }

  Future<void> _onAuthStateChanged() async {
    final usuarioLogado = _authRepository.usuarioLogado;
    if (usuarioLogado != null) {
      await getCompromissos.execute();
    } else {
      _compromissos = [];
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _authRepository.removeListener(_onAuthStateChanged);
    super.dispose();
  }
}
