import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pbl6_mobile/review_post/review_post.dart';

class ReviewPostPage extends StatelessWidget {
  const ReviewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewPostBloc(),
      child: const ReviewPostView(),
    );
  }
}

class ReviewPostView extends StatelessWidget {
  const ReviewPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('ReviewPostView is working'),
      ),
    );
  }
}
