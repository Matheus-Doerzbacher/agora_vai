import 'package:agora_vai/data/repository/auth_repository.dart';
import 'package:agora_vai/data/repository/compromisso_repository.dart';
import 'package:agora_vai/data/repository/lembrete_repository.dart';
import 'package:agora_vai/data/repository/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class UserViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UsuarioRepository _usuarioRepository;
  final LembreteRepository _lembreteRepository;
  final CompromissoRepository _compromissoRepository;

  UserViewModel({
    required AuthRepository authRepository,
    required UsuarioRepository usuarioRepository,
    required LembreteRepository lembreteRepository,
    required CompromissoRepository compromissoRepository,
  }) : _authRepository = authRepository,
       _usuarioRepository = usuarioRepository,
       _lembreteRepository = lembreteRepository,
       _compromissoRepository = compromissoRepository;

  late final deleteUser = Command0(_deleteUser);

  AsyncResult<Unit> _deleteUser() async {
    final usuario = _authRepository.usuarioLogado;
    if (usuario == null) {
      return Failure(Exception('Usuário não está logado'));
    }

    // Buscar todos os lembretes do usuário
    final lembretes = await _lembreteRepository.getLembretes().getOrThrow();

    // Deletar todos os lembretes
    for (final lembrete in lembretes) {
      await _lembreteRepository.delete(lembrete.idLembrete).getOrThrow();
    }

    // Buscar todos os compromissos do usuário
    final compromissos = await _compromissoRepository
        .getCompromissos()
        .getOrThrow();

    // Deletar todos os compromissos
    for (final compromisso in compromissos) {
      await _compromissoRepository
          .delete(compromisso.idCompromisso)
          .getOrThrow();
    }

    // Deletar o usuário
    await _usuarioRepository.deleteUser(usuario.idUsuario).getOrThrow();

    // Fazer logout
    return _authRepository.logout();
  }
}
