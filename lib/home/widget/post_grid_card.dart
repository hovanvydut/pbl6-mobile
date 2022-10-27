import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pbl6_mobile/app/app.dart';

class PostGridCard extends StatelessWidget {
  const PostGridCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                    imageUrl:
                        'https://thichonha.com/wp-content/uploads/2021/09/y-tuong-decor-phong-tro.jpg',
                    imageBuilder: (context, imageProvider) => Container(
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
                  IconButton(
                    icon: Assets.icons.bookmarkOutline.svg(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    onPressed: () {},
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
                    Text(
                      'Phòng trọ mới xây ở Trưng Nữ Vương',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${2000000.inCompactLongCurrency}/tháng',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '01 An Cư 6, Phường Hòa An, quận Cẩm Lệ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
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
    );
  }
}
