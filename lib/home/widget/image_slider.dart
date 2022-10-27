import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pbl6_mobile/app/app.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late final ValueNotifier<int> _currentIndexNotifier;

  @override
  void initState() {
    super.initState();
    _currentIndexNotifier = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.28,
          child: PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (index) {
              _currentIndexNotifier.value = index;
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                cacheManager: AppCacheManager.appConfig,
                imageUrl: widget.images[index],
                imageBuilder: (context, imageProvider) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: Assets.images.notImage.image().image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Wrap(
          children: widget.images
              .asMap()
              .entries
              .map<Widget>(
                (entry) => ValueListenableBuilder<int>(
                  valueListenable: _currentIndexNotifier,
                  builder: (context, index, child) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 12,
                      width: entry.key == index ? 36 : 12,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: entry.key == index
                            ? theme.colorScheme.primary
                            : theme.colorScheme.primaryContainer,
                      ),
                    );
                  },
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
