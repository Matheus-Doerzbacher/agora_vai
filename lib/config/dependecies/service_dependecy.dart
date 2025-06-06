import 'package:agora_vai/data/service/api/auth_service.dart';
import 'package:agora_vai/data/service/api/client/api_client.dart';
import 'package:agora_vai/data/service/api/client/auth_api_client.dart';
import 'package:agora_vai/data/service/api/compromisso_service.dart';
import 'package:agora_vai/data/service/api/lembrete_service.dart';
import 'package:agora_vai/data/service/api/usuario_service.dart';
import 'package:agora_vai/data/service/local/shared_preferences_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> serviceProviders = [
  Provider(create: (context) => ApiClient()),
  Provider(create: (context) => AuthApiClient()),
  Provider(create: (context) => SharedPreferencesService()),
  Provider(
    create: (context) =>
        AuthService(apiClient: context.read(), authApiClient: context.read()),
  ),
  Provider(create: (context) => UsuarioService(apiClient: context.read())),
  Provider(create: (context) => LembreteService(apiClient: context.read())),
  Provider(create: (context) => CompromissoService(apiClient: context.read())),
];
