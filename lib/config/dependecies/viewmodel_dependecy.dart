import 'package:agora_vai/ui/auth/login/login_viewmodel.dart';
import 'package:agora_vai/ui/auth/logout/logout_viewmodel.dart';
import 'package:agora_vai/ui/compromisso/compromisso_viewmodel.dart';
import 'package:agora_vai/ui/lembrete/lembrete_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> viewmodelProviders = [
  ChangeNotifierProvider(
    create: (context) => LoginViewModel(
      authRepository: context.read(),
      usuarioRepository: context.read(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => LogoutViewModel(authRepository: context.read()),
  ),
  ChangeNotifierProvider(
    create: (context) => LembreteViewModel(
      lembreteRepository: context.read(),
      authRepository: context.read(),
      notiRepository: context.read(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => CompromissoViewModel(
      compromissoRepository: context.read(),
      authRepository: context.read(),
      notiRepository: context.read(),
    ),
  ),
];
