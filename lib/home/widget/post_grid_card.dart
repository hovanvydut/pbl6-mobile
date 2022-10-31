import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
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
        extra: ExtraParams2<PostBloc, Post>(
          param1: context.read<PostBloc>(),
          param2: post,
        ),
      ),
      child: SizedBox(
        height: 260,
        width: 180,
        child: Card(
          child: Column(
            children: [
              SizedBox(
                height: 130,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
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
                      onBookmarkedPressed: () => context
                          .read<BookmarkBloc>()
                          .add(DeleteBookmark(post)),
                      onUnBookmarkedPressed: () =>
                          context.read<BookmarkBloc>().add(AddBookmark(post)),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Text(
                          post.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${post.price.inCompactLongCurrency}/tháng',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${post.address}, ${post.fullAddress}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BookmarkIconButton extends StatelessWidget {
  const BookmarkIconButton({
    super.key,
    this.isBookmarked = false,
    required this.onBookmarkedPressed,
    required this.onUnBookmarkedPressed,
  });

  final bool isBookmarked;
  final VoidCallback onBookmarkedPressed;
  final VoidCallback onUnBookmarkedPressed;

  @override
  Widget build(BuildContext context) {
    if (context.watch<AuthenticationBloc>().state.user == null) {
      return const SizedBox();
    }
    if (isBookmarked) {
      return Positioned(
        top: 4,
        right: 4,
        child: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.6),
          child: IconButton(
            icon: Assets.icons.bookmarkBold.svg(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: onBookmarkedPressed.call,
          ),
        ),
      );
    } else {
      return Positioned(
        top: 4,
        right: 4,
        child: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.6),
          child: IconButton(
            icon: Assets.icons.bookmarkOutline.svg(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: onUnBookmarkedPressed.call,
          ),
        ),
      );
    }
  }
}
