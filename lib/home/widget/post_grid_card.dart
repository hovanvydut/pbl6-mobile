import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';

class PostGridCard extends StatelessWidget {
  const PostGridCard({
    super.key,
    required this.post,
    this.isBookmarked = false,
  });

  final Post post;
  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        AppRouter.detailPost,
        extra: ExtraParams3<UserPostBloc, Post, BookmarkBloc>(
          param1: context.read<UserPostBloc>(),
          param2: post,
          param3: context.read<BookmarkBloc>(),
        ),
      ),
      child: SizedBox(
        height: 260,
        width: 180,
        child: Card(
          child: Column(
            children: [
              PostGridCardImage(post: post, isBookmarked: isBookmarked),
              PostGridInformation(post: post)
            ],
          ),
        ),
      ),
    );
  }
}

class PostGridInformation extends StatelessWidget {
  const PostGridInformation({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    post.title,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(
              '${post.price.inCompactCurrency}/tháng',
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${post.address}, ${post.fullAddress}',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class PostGridCardImage extends StatelessWidget {
  const PostGridCardImage({
    super.key,
    required this.post,
    required this.isBookmarked,
  });

  final Post post;
  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    final isUserPost = context
        .watch<UserPostBloc>()
        .state
        .userPostsData
        .any((userPost) => userPost.id == post.id);

    return SizedBox(
      height: 130,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          if (post.medias.isEmpty) ...[
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: Assets.images.notImage.image().image,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ] else
            CachedNetworkImage(
              cacheManager: AppCacheManager.appConfig,
              imageUrl: post.medias.first.url,
              imageBuilder: (context, imageProvider) => Hero(
                tag: post.toString(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: Assets.images.notImage.image().image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (post.isPriorityPost ?? false)
                    Tooltip(
                      message: 'Đây là bài viết uptop',
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Assets.icons.checkCert.svg(
                            color: context.colorScheme.primary,
                            height: 32,
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(),
                  if (!isUserPost)
                    PermissionWrapper(
                      permission: Permission.bookmarkCreate,
                      child: BookmarkIconButton(
                        isBookmarked: isBookmarked,
                        onBookmarkedPressed: () => context
                            .read<BookmarkBloc>()
                            .add(DeleteBookmark(post)),
                        onUnBookmarkedPressed: () =>
                            context.read<BookmarkBloc>().add(AddBookmark(post)),
                      ),
                    )
                  else
                    const SizedBox(),
                ],
              ),
              const Spacer(),
              RatingBar(
                itemSize: 24,
                itemCount: 4,
                ratingWidget: RatingWidget(
                  full: Assets.icons.starBold.svg(color: Colors.yellow),
                  half: const SizedBox(),
                  empty: Assets.icons.starOutline
                      .svg(color: context.colorScheme.outline),
                ),
                initialRating: post.averageRating ?? 0.0,
                ignoreGestures: true,
                onRatingUpdate: (_) {},
              ),
              const SizedBox(height: 8),
            ],
          )
        ],
      ),
    );
  }
}
