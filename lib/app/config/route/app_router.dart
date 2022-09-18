import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/login/login.dart';
import 'package:pbl6_mobile/register/register.dart';

abstract class AppRouter {
  static const login = '/login';
  static const register = '/register';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: register,
        builder: (context, state) {
          return const RegisterPage();
        },
      ),
    ],
    initialLocation: login,
    urlPathStrategy: UrlPathStrategy.path,
    debugLogDiagnostics: true,
  );
}
