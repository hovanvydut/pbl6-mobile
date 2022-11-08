import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:widgets/widgets.dart';

class CachedNetworkImageSlider extends StatefulWidget {
  const CachedNetworkImageSlider({
    super.key,
    required this.images,
    required this.imageError,
    required this.height,
    this.cacheManager,
    this.margin = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
    this.showIndicator = true,
  });

  final List<String> images;
  final ImageProvider<Object> imageError;
  final double height;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final BaseCacheManager? cacheManager;
  final bool showIndicator;

  @override
  State<CachedNetworkImageSlider> createState() =>
      _CachedNetworkImageSliderState();
}

class _CachedNetworkImageSliderState extends State<CachedNetworkImageSlider> {
  late final ValueNotifier<int> _currentIndexNotifier;

  @override
  void initState() {
    super.initState();
    _currentIndexNotifier = ValueNotifier(0);
  }

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (index) {
              _currentIndexNotifier.value = index;
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                cacheManager: widget.cacheManager,
                imageUrl: widget.images[index],
                imageBuilder: (context, imageProvider) => GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          FullImageView(imageUrl: widget.images[index]),
                    ),
                  ),
                  child: Container(
                    margin: widget.margin,
                    decoration: BoxDecoration(
                      borderRadius: widget.borderRadius,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                  margin: widget.margin,
                  decoration: BoxDecoration(
                    borderRadius: widget.borderRadius,
                    image: DecorationImage(
                      image: widget.imageError,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.showIndicator && widget.images.length > 1) ...[
          const SizedBox(
            height: 16,
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
                        height: 8,
                        width: entry.key == index ? 24 : 8,
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
          ),
        ] else
          const SizedBox(
            height: 8,
          ),
      ],
    );
  }
}
