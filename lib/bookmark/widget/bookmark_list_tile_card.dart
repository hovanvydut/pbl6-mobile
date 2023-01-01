import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';

class BookmarklListTileCard extends StatelessWidget {
  const BookmarklListTileCard({
    super.key,
    required this.bookmark,
  });

  final Post bookmark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: GestureDetector(
        onTap: () => context.push(
          AppRouter.detailPost,
          extra: ExtraParams3<UserPostBloc, Post, BookmarkBloc>(
            param1: context.read<UserPostBloc>(),
            param2: bookmark,
            param3: context.read<BookmarkBloc>(),
          ),
        ),
        child: Card(
          color: context.colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: Row(
              children: [
                if (bookmark.medias.isNotEmpty)
                  Expanded(
                    flex: 4,
                    child: CachedNetworkImage(
                      cacheManager: AppCacheManager.appConfig,
                      imageUrl: bookmark.medias.first.url,
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
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
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
                        Text(
                          bookmark.title,
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${bookmark.price.inCompactCurrency}/tháng',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: context.colorScheme.primary,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${bookmark.address}, ${bookmark.fullAddress}',
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
                PermissionWrapper(
                  permission: Permission.bookmarkRemove,
                  child: Column(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Assets.icons.close.svg(
                          color: context.colorScheme.onSurface,
                        ),
                        onPressed: () => context
                            .read<BookmarkBloc>()
                            .add(DeleteBookmark(bookmark)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
