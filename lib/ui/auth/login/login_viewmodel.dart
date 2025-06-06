import 'package:agora_vai/data/repository/auth_repository.dart';
import 'package:agora_vai/data/repository/usuario_repository.dart';
import 'package:agora_vai/data/service/api/model/auth/login_request.dart';
import 'package:agora_vai/data/service/api/model/usuario/usuario_create.dart';
import 'package:agora_vai/domain/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({
    required AuthRepository authRepository,
    required UsuarioRepository usuarioRepository,
  }) : _authRepository = authRepository,
       _usuarioRepository = usuarioRepository;

  final AuthRepository _authRepository;
  final UsuarioRepository _usuarioRepository;

  late final login = Command1(_login);
  late final createUser = Command1(_createUser);

  AsyncResult<Unit> _login(LoginRequest loginRequest) async {
    return _authRepository.login(loginRequest);
  }

  AsyncResult<Usuario> _createUser(UsuarioCreate usuario) async {
    return _usuarioRepository.createUser(usuario);
  }
}
