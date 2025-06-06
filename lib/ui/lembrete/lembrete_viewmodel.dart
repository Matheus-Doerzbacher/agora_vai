import 'package:agora_vai/data/repository/auth_repository.dart';
import 'package:agora_vai/data/repository/lembrete_repository.dart';
import 'package:agora_vai/data/service/api/model/lembrete/lembrete_create.dart';
import 'package:agora_vai/domain/model/lembrete.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class LembreteViewModel extends ChangeNotifier {
  final LembreteRepository _lembreteRepository;
  final AuthRepository _authRepository;

  LembreteViewModel({
    required LembreteRepository lembreteRepository,
    required AuthRepository authRepository,
  }) : _lembreteRepository = lembreteRepository,
       _authRepository = authRepository {
    _authRepository.addListener(_onAuthStateChanged);
    getLembretes.execute();
  }

  Future<void> _onAuthStateChanged() async {
    final isAuthenticated = await _authRepository.isAuthenticated;
    if (isAuthenticated) {
      await getLembretes.execute();
    } else {
      _lembretes = [];
      notifyListeners();
    }
  }

  late final createLembrete = Command1(_createLembrete);
  late final getLembretes = Command0(_getLembretes);

  List<Lembrete> _lembretes = [];
  List<Lembrete> get lembretes => _lembretes;

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
}
