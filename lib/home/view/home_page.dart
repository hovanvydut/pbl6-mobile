import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        title: Assets.images.logo.svg(),
        actions: [
          IconButton(
            icon: Assets.icons.searchBold.svg(
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () => context.push(AppRouter.searchFilter),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSlider(images: images),
            const SizedBox(height: 16),
            const PriorityPostGridView(),
          ],
        ),
      ),
    );
  }
}
