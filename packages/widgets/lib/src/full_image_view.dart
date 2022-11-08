import 'dart:io' as io;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ImageType { local, network }

class FullImageView extends StatelessWidget {
  const FullImageView({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final imageType = getImageType(imageUrl);
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: InteractiveViewer(
          child: Center(
            child: Hero(
              tag: imageUrl,
              child: imageType == ImageType.network
                  ? CachedNetworkImage(imageUrl: imageUrl)
                  : Image.file(io.File(imageUrl)),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  ImageType getImageType(String imageUrl) {
    final uri = Uri.parse(imageUrl);
    switch (uri.scheme) {
      case 'file':
        return ImageType.local;
      case 'http':
      case 'https':
        return ImageType.network;
      default:
        return ImageType.local;
    }
  }
}
