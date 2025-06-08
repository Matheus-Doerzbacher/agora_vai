import 'package:agora_vai/data/repository/auth_repository.dart';
import 'package:agora_vai/data/repository/compromisso_repository.dart';
import 'package:agora_vai/data/repository/lembrete_repository.dart';
import 'package:agora_vai/data/repository/noti_repository.dart';
import 'package:agora_vai/data/repository/usuario_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> respositoryProviders = [
  ChangeNotifierProvider(
    create: (context) {
      return AuthRepository(
        apiClient: context.read(),
        authService: context.read(),
        sharedPreferencesService: context.read(),
      );
    },
  ),
  Provider(
    create: (context) => LembreteRepository(lembreteService: context.read()),
  ),
  Provider(
    create: (context) => UsuarioRepository(usuarioService: context.read()),
  ),
  Provider(
    create: (context) =>
        CompromissoRepository(compromiCompromissoService: context.read()),
  ),
  Provider(create: (context) => NotiRepository(notiService: context.read())),
];
