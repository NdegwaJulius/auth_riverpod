import 'package:auth_riverpod/providers/states/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:auth_riverpod/providers/login_controller_provider.dart';
import 'package:auth_riverpod/ui/home_page.dart';
import 'package:auth_riverpod/ui/login_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    routes: router.routes,
    redirect: router.redirectLogic,
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<LoginState>(loginControllerProvider, (previous, next) {
      notifyListeners();
    });
  }

  String? redirectLogic(BuildContext context, GoRouterState state) {
    final isLoggedIn = _ref.read(loginControllerProvider);
    final isLoginState = state.matchedLocation == '/login';

    if (isLoggedIn is LoginInitial || isLoggedIn is LoginError) {
      return isLoginState ? null : '/login';  // Ensure user is redirected to login if not logged in
    }

    if (isLoggedIn is LoginSuccess) {
      return isLoginState ? '/' : null;  // Redirect to home if logged in and trying to access login
    }

    return null; // Return null if no redirection is needed
  }

  List<GoRoute> get routes => [
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const MaterialPage(
        child: LoginPage(title: 'Login'),
      ),
    ),
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(
        child: HomePage(),
      ),
    ),
  ];
}
