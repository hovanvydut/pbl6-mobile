import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Assets.icons.arrorLeft.svg(
            color: theme.colorScheme.onSurface,
            height: 32,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Bài viết đã lưu',
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('BookmarkView is working'),
      ),
    );
  }
}
