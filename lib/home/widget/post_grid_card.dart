import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/post/post.dart';

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
        extra: ExtraParams3<PostBloc, Post, BookmarkBloc>(
          param1: context.read<PostBloc>(),
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(
              '${post.price.inCompactCurrency}/tháng',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${post.address}, ${post.fullAddress}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
          BookmarkIconButton(
            isBookmarked: isBookmarked,
            onBookmarkedPressed: () =>
                context.read<BookmarkBloc>().add(DeleteBookmark(post)),
            onUnBookmarkedPressed: () =>
                context.read<BookmarkBloc>().add(AddBookmark(post)),
          )
        ],
      ),
    );
  }
}
