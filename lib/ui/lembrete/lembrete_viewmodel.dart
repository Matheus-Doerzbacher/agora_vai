import 'dart:async';

import 'package:agora_vai/core/compara_datas.dart';
import 'package:agora_vai/core/print_custom.dart';
import 'package:agora_vai/data/repository/auth_repository.dart';
import 'package:agora_vai/data/repository/lembrete_repository.dart';
import 'package:agora_vai/data/repository/noti_repository.dart';
import 'package:agora_vai/data/service/api/model/lembrete/lembrete_create.dart';
import 'package:agora_vai/domain/model/lembrete.dart';
import 'package:agora_vai/domain/model/notificacao.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class LembreteViewModel extends ChangeNotifier {
  final LembreteRepository _lembreteRepository;
  final AuthRepository _authRepository;
  final NotiRepository _notiRepository;

  LembreteViewModel({
    required LembreteRepository lembreteRepository,
    required AuthRepository authRepository,
    required NotiRepository notiRepository,
  }) : _lembreteRepository = lembreteRepository,
       _authRepository = authRepository,
       _notiRepository = notiRepository {
    _authRepository.addListener(_onAuthStateChanged);
    getLembretes.execute();
    _iniciarVerificacaoLembretes();
  }

  final _print = PrintCustom('LembreteViewModel');

  late final createLembrete = Command1(_createLembrete);
  late final getLembretes = Command0(_getLembretes);
  late final deleteLembrete = Command1(_deleteLembrete);
  late final updateLembrete = Command2(_updateLembrete);

  List<Lembrete> _lembretes = [];
  List<Lembrete> get lembretes => _lembretes;
  Timer? _timer;

  void _iniciarVerificacaoLembretes() {
    _timer?.cancel();

    // Calcula o tempo até o próximo minuto
    final now = DateTime.now();
    final nextMinute = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute + 1,
    );
    final delay = nextMinute.difference(now);

    // Agenda o primeiro timer para começar no próximo minuto
    Future.delayed(delay, () {
      _verificarLembretes();

      // Depois inicia o timer periódico
      _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        _verificarLembretes();
      });
    });
  }

  Future<void> _verificarLembretes() async {
    _print
      ..title('Iniciando verificação de lembretes')
      ..info('Hora atual: ${DateTime.now()}');

    for (final lembrete in _lembretes) {
      if (lembrete.dataHora == null) continue;

      if (comparaDatas(DateTime.now(), lembrete.dataHora!) &&
          !lembrete.isConcluido) {
        _print
          ..success('Lembrete encontrado')
          ..success('Lembrete: ${lembrete.descricao}');
        await _notiRepository.showNotification(
          Notificacao(
            id: lembrete.idLembrete,
            title: lembrete.titulo,
            body: lembrete.descricao,
          ),
        );
      }
    }
    _print
      ..info('Verificação de lembretes finalizada')
      ..line();
  }

  AsyncResult<Unit> _createLembrete(CreateLembrete createLembrete) async {
    final result = await _lembreteRepository.create(createLembrete);

    return result.fold(
      (lembrete) {
        _lembretes.add(lembrete);
        notifyListeners();
        return const Success(unit);
      },
      (failure) {
        return Failure(failure);
      },
    );
  }

  AsyncResult<List<Lembrete>> _getLembretes() async {
    final result = await _lembreteRepository.getLembretes();

    result.fold(
      (lembretes) {
        _lembretes = lembretes;
        notifyListeners();
      },
      (failure) {
        return Failure(failure);
      },
    );

    return result;
  }

  AsyncResult<Unit> _updateLembrete(
    CreateLembrete createLembrete,
    int idLembrete,
  ) async {
    final result = await _lembreteRepository.update(createLembrete, idLembrete);

    return result.fold(
      (lembrete) {
        final index = _lembretes.indexWhere(
          (lembrete) => lembrete.idLembrete == idLembrete,
        );
        _lembretes[index] = lembrete;
        notifyListeners();
        return const Success(unit);
      },
      (failure) {
        return Failure(failure);
      },
    );
  }

  AsyncResult<Unit> _deleteLembrete(int idLembrete) async {
    final result = await _lembreteRepository.delete(idLembrete);

    return result.fold(
      (success) {
        _lembretes.removeWhere((lembrete) => lembrete.idLembrete == idLembrete);
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
      await getLembretes.execute();
    } else {
      _lembretes = [];
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _authRepository.removeListener(_onAuthStateChanged);
    super.dispose();
  }
}
