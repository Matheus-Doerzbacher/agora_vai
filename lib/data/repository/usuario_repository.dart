import 'package:agora_vai/data/service/api/model/usuario/usuario_create.dart';
import 'package:agora_vai/data/service/api/usuario_service.dart';
import 'package:agora_vai/domain/model/usuario.dart';
import 'package:result_dart/result_dart.dart';

class UsuarioRepository {
  final UsuarioService _usuarioService;

  UsuarioRepository({required UsuarioService usuarioService})
    : _usuarioService = usuarioService;

  AsyncResult<Usuario> createUser(UsuarioCreate usuario) async {
    return _usuarioService.create(usuario);
  }
}
