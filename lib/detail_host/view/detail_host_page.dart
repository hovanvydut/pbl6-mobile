import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/detail_host/detail_host.dart';
import 'package:post/post.dart';

class DetailHostPage extends StatelessWidget {
  const DetailHostPage({super.key, required this.host});

  final User host;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailHostCubit(
        host: host,
        postRepository: context.read<PostRepository>(),
      ),
      child: const DetailHostView(),
    );
  }
}

class DetailHostView extends StatelessWidget {
  const DetailHostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('DetailHostView is working'),
      ),
    );
  }
}
