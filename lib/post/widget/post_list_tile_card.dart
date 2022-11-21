import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:shimmer/shimmer.dart';

class PostListTileCard extends StatelessWidget {
  const PostListTileCard({
    super.key,
    required this.post,
    this.isBookmarked = false,
    this.hideBookmark = false,
    required this.onCardTap,
  });

  final Post post;
  final bool isBookmarked;
  final bool hideBookmark;
  final VoidCallback onCardTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          onCardTap.call();
        },
        child: Card(
          color: context.colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: Row(
              children: [
                if (post.medias.isNotEmpty)
                  Expanded(
                    flex: 4,
                    child: CachedNetworkImage(
                      cacheManager: AppCacheManager.appConfig,
                      imageUrl: post.medias.first.url,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: kShimmerBaseColor,
                        highlightColor: kShimmerHightlightColor,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          Assets.images.notImage.image(
                        fit: BoxFit.cover,
                        height: 120,
                      ),
                    ),
                  )
                else
                  Expanded(
                    flex: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Assets.images.notImage.image(
                        fit: BoxFit.cover,
                        height: 120,
                      ),
                    ),
                  ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                post.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
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
                        Text(
                          '${post.price.inCompactCurrency}/tháng',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
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
                ),
                if (!hideBookmark)
                  Column(
                    children: [
                      BookmarkIconButton(
                        isBookmarked: isBookmarked,
                        onBookmarkedPressed: () => context
                            .read<BookmarkBloc>()
                            .add(DeleteBookmark(post)),
                        onUnBookmarkedPressed: () =>
                            context.read<BookmarkBloc>().add(AddBookmark(post)),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
