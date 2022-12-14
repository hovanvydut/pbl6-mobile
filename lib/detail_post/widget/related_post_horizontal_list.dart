import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/detail_post/detail_post.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';

class RelatedPostHorizonalList extends StatelessWidget {
  const RelatedPostHorizonalList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final relatedPosts =
            context.select((DetailPostCubit bloc) => bloc.state.relatedPosts);
        final relatedPostLoadingStatus = context.select(
          (DetailPostCubit bloc) => bloc.state.relatedPostLoadingStatus,
        );
        if (relatedPostLoadingStatus == LoadingStatus.loading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Tin nhà trọ khác',
                  style: context.textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: context.width,
                      child: const PostListTileCardPlaceholder(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 8,
                    );
                  },
                ),
              ),
            ],
          );
        }
        if (relatedPostLoadingStatus == LoadingStatus.error) {
          return const SizedBox();
        }
        if (relatedPosts.isEmpty) {
          return const SizedBox();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Tin nhà trọ khác',
                style: context.textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 140,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: relatedPosts.length,
                itemBuilder: (context, index) {
                  final post = relatedPosts[index];
                  return SizedBox(
                    width: context.width,
                    child: PostListTileCard(
                      key: ValueKey(post.id),
                      post: post,
                      hideBookmark: true,
                      onCardTap: () => context.push(
                        AppRouter.detailPost,
                        extra: ExtraParams3<UserPostBloc, Post, BookmarkBloc?>(
                          param1: context.read<UserPostBloc>(),
                          param2: post,
                          param3: context.read<BookmarkBloc>(),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 12,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
