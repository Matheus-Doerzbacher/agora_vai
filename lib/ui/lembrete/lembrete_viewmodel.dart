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

  late final createLembrete = Command1(_createLembrete);
  late final getLembretes = Command0(_getLembretes);
  late final deleteLembrete = Command1(_deleteLembrete);
  late final updateLembrete = Command2(_updateLembrete);

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
    _authRepository.removeListener(_onAuthStateChanged);
    super.dispose();
  }
}
