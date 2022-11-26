import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/post/post.dart';

class TrendingDistrictBox extends StatelessWidget {
  const TrendingDistrictBox({
    super.key,
    required this.district,
  });

  final Map<String, Object> district;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: AppCacheManager.appConfig,
      imageUrl: district['imageUrl']! as String,
      imageBuilder: (context, imageProvider) {
        return GestureDetector(
          onTap: () => context.push(
            AppRouter.searchFilter,
            extra: ExtraParams3<PostBloc, BookmarkBloc, int>(
              param1: context.read<PostBloc>(),
              param2: context.read<BookmarkBloc>(),
              param3: district['id']! as int,
            ),
          ),
          child: Hero(
            tag: district['imageUrl']! as String,
            child: AspectRatio(
              aspectRatio: 1.2,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.1, 0.4],
                        colors: [
                          Colors.black54,
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      district['name']! as String,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: lightColorScheme.surface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      placeholder: (context, url) => const AspectRatio(
        aspectRatio: 1.2,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => AspectRatio(
        aspectRatio: 1.2,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: Assets.images.notImage.image().image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
