import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:widgets/widgets.dart';

class DetailPostImage extends StatelessWidget {
  const DetailPostImage({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (post.medias.isNotEmpty)
          CachedNetworkImageSlider(
            height: 250,
            images: post.medias.map((media) => media.url).toList(),
            imageError: Assets.images.notImage.image().image,
          )
        else
          Assets.images.notImage.image(
            fit: BoxFit.cover,
            height: 250,
          ),
        if (post.isPriorityPost ?? false)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Assets.icons.checkCert
                  .svg(height: 40, color: context.colorScheme.primary),
            ),
          ),
      ],
    );
  }
}
