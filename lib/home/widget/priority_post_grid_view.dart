import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/home/home.dart';
import 'package:pbl6_mobile/post/post.dart';

class PriorityPostGridView extends StatelessWidget {
  const PriorityPostGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          final allPosts = state.allPostsData;
          final allPostsStatus = state.allPostsLoadingStatus;
          if (allPostsStatus == LoadingStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (allPostsStatus == LoadingStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.errorNotFound.svg(
                    height: 200,
                    width: 300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Không thể cập nhật phòng trọ nổi bật, xin thử lại',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  )
                ],
              ),
            );
          }
          if (allPosts.isEmpty) {
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Phòng trọ nổi bật',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              GridView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                shrinkWrap: true,
                primary: false,
                itemCount: allPosts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 260,
                ),
                itemBuilder: (context, index) {
                  final post = allPosts[index];
                  return PostGridCard(post: post);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
