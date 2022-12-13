import 'package:bookmark/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/main/view/host_main_view.dart';
import 'package:pbl6_mobile/main/view/unauth_main_view.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';
import 'package:pbl6_mobile/user_profile/user_profile.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:post/post.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserPostBloc(
            postRepository: context.read<PostRepository>(),
            authenticationBloc: context.read<AuthenticationBloc>(),
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => UserProfileBloc(),
        ),
        BlocProvider(
          create: (context) => BookmarkBloc(
            bookmarkRepository: context.read<BookmarkRepository>(),
            authenticationBloc: context.read<AuthenticationBloc>(),
          ),
        ),
      ],
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is EndSession) {
            ToastHelper.showToast('Đã hết phiên đăng nhập');
          }
          if (state is Unauthenticated) {
            ToastHelper.showToast('Đã đăng xuất');
          }
        },
        builder: (context, state) {
          if (state is Unknown ||
              state is EndSession ||
              state is Unauthenticated) {
            return const UnAuthMainView();
          }

          /// TODO: role
          return const HostMainView();
        },
      ),
    );
  }
}
