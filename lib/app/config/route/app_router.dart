import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/main/main.dart';
import 'package:pbl6_mobile/upload_post/upload_post.dart';

abstract class AppRouter {
  static const main = '/';
  static const uploadBlog = '/upload';

  static final router = GoRouter(
    routes: [
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
    urlPathStrategy: UrlPathStrategy.path,
    debugLogDiagnostics: true,
  );
}
