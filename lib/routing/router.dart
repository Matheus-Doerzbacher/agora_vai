import 'package:agora_vai/data/repository/auth_repository.dart';
import 'package:agora_vai/routing/routes.dart';
import 'package:agora_vai/ui/auth/login/login_page.dart';
import 'package:agora_vai/ui/home/home_page.dart';
import 'package:agora_vai/ui/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  debugLogDiagnostics: true,
  redirect: _redirect,
  refreshListenable: authRepository,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => LoginPage(viewModel: context.read()),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: Routes.user,
          builder: (context, state) => const UserPage(),
        ),
      ],
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final isLoggedIn = await context.read<AuthRepository>().isAuthenticated;
  final loggingIn = state.matchedLocation == Routes.login;

  if (!isLoggedIn) {
    return Routes.login;
  }

  if (loggingIn) {
    return Routes.home;
  }

  return null;
}
