import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/edit_user_profile/edit_user_profile.dart';
import 'package:pbl6_mobile/login/login.dart';
import 'package:pbl6_mobile/main/main.dart';
import 'package:pbl6_mobile/register/register.dart';
import 'package:pbl6_mobile/upload_post/upload_post.dart';

abstract class AppRouter {
  static const login = '/login';
  static const register = '/register';
  static const main = '/';
  static const uploadBlog = '/upload';
  static const editUserProfile = 'edit-profile';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: main,
        builder: (context, state) {
          return const MainPage();
        },
        routes: [
          GoRoute(
            path: editUserProfile,
            builder: (context, state) {
              final user = state.extra! as User;
              return EditUserProfilePage(user: user);
            },
          ),
        ],
      ),
      GoRoute(
        path: uploadBlog,
        builder: (context, state) {
          return const UploadPostPage();
        },
      ),
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
    urlPathStrategy: UrlPathStrategy.path,
    debugLogDiagnostics: true,
  );
}
