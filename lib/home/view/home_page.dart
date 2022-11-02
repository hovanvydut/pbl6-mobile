import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/home/home.dart';
import 'package:pbl6_mobile/post/post.dart';
import 'package:widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        postBloc: context.read<PostBloc>(),
      ),
      lazy: false,
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final images = [
      'https://bandon.vn/uploads/posts/thiet-ke-nha-tro-dep-2020-bandon-0.jpg',
      'https://i.pinimg.com/736x/7d/cb/07/7dcb07b39f6e5a165112c62cbbb23c65.jpg',
      'https://xaydungthuanphuoc.com/wp-content/uploads/2022/09/mau-phong-tro-co-gac-lung-dep2013-7.jpg',
    ];
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'PBL6 HOMIE',
            );
          },
          child: Assets.images.logo.svg(),
        ),
        actions: [
          IconButton(
            icon: Assets.icons.searchBold.svg(
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () => context.push(
              AppRouter.searchFilter,
              extra: ExtraParams2<PostBloc, BookmarkBloc>(
                param1: context.read<PostBloc>(),
                param2: context.read<BookmarkBloc>(),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImageSlider(
              images: images,
              height: context.height * 0.28,
              imageError: Assets.images.notImage.image().image,
            ),
            const SizedBox(height: 16),
            const PriorityPostGridView(),
          ],
        ),
      ),
    );
  }
}
