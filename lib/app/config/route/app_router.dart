import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/edit_post/edit_post.dart';
import 'package:pbl6_mobile/edit_user_profile/edit_user_profile.dart';
import 'package:pbl6_mobile/login/login.dart';
import 'package:pbl6_mobile/main/main.dart';
import 'package:pbl6_mobile/main/view/guest_main_view.dart';
import 'package:pbl6_mobile/main/view/host_main_view.dart';
import 'package:pbl6_mobile/post/post.dart';
import 'package:pbl6_mobile/register/register.dart';
import 'package:pbl6_mobile/search_filter/search_filter.dart';
import 'package:pbl6_mobile/upload_post/upload_post.dart';

abstract class AppRouter {
  static const login = '/login';
  static const register = '/register';
  static const main = '/';
  static const guest = '/guest';
  static const host = '/host';
  static const uploadPost = '/upload';
  static const editUserProfile = 'edit-profile';
  static const detailPost = '/detail';
  static const editPost = '/edit-post';
  static const searchFilter = '/search-filter';
  static const bookmark = '/bookmark';

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
        path: searchFilter,
        builder: (context, state) {
          return const SearchFilterPage();
        },
      ),
      GoRoute(
        path: guest,
        builder: (context, state) {
          return const GuestMainView();
        },
      ),
      GoRoute(
        path: host,
        builder: (context, state) {
          return const HostMainView();
        },
      ),
      GoRoute(
        path: uploadPost,
        builder: (context, state) {
          final postBloc = state.extra! as PostBloc;
          return BlocProvider.value(
            value: postBloc,
            child: const UploadPostPage(),
          );
        },
      ),
      GoRoute(
        path: detailPost,
        builder: (context, state) {
          final extras = state.extra! as ExtraParams2<PostBloc, Post>;
          return BlocProvider.value(
            value: extras.param1,
            child: DetailPostPage(post: extras.param2),
          );
        },
      ),
      GoRoute(
        path: editPost,
        builder: (context, state) {
          final extras = state.extra! as ExtraParams2<PostBloc, Post>;
          return BlocProvider.value(
            value: extras.param1,
            child: EditPostPage(post: extras.param2),
          );
        },
      ),
      GoRoute(
        path: login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: bookmark,
        builder: (context, state) {
          final bookmarkBloc = state.extra! as BookmarkBloc;
          return BlocProvider.value(
            value: bookmarkBloc,
            child: const BookmarkPage(),
          );
        },
      ),
      GoRoute(
        path: register,
        builder: (context, state) {
          return const RegisterPage();
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

class ExtraParams2<A, B> {
  ExtraParams2({
    required this.param1,
    required this.param2,
  });
  final A param1;
  final B param2;
}

class ExtraParams3<A, B, C> {
  ExtraParams3({
    required this.param1,
    required this.param2,
    required this.param3,
  });
  final A param1;
  final B param2;
  final C param3;
}
