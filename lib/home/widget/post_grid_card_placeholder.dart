import 'package:flutter/material.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:shimmer/shimmer.dart';

class PostGridCardPlaceholder extends StatelessWidget {
  const PostGridCardPlaceholder({super.key});

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
                  Shimmer.fromColors(
                    baseColor: kShimmerBaseColor,
                    highlightColor: kShimmerHightlightColor,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: CircleAvatar(
                      backgroundColor: context.colorScheme.surface,

                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Shimmer.fromColors(
                        baseColor: kShimmerBaseColor,
                        highlightColor: kShimmerHightlightColor,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: kShimmerBaseColor,
                        highlightColor: kShimmerHightlightColor,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: kShimmerBaseColor,
                        highlightColor: kShimmerHightlightColor,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                        ),
                      ),
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
