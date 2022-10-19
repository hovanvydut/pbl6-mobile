import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/login/login.dart';
import 'package:pbl6_mobile/main/main.dart';
import 'package:pbl6_mobile/register/register.dart';
import 'package:pbl6_mobile/upload_post/upload_post.dart';

abstract class AppRouter {
  static const login = '/login';
  static const register = '/register';
  static const main = '/main';
  static const uploadBlog = '/upload';

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
      GoRoute(
        path: main,
        builder: (context, state) {
          return const MainPage();
        },
      ),
      GoRoute(
        path: uploadBlog,
        builder: (context, state) {
          return const UploadPostPage();
        },
      ),
    ],
    initialLocation: login,
    urlPathStrategy: UrlPathStrategy.path,
    debugLogDiagnostics: true,
  );
}
