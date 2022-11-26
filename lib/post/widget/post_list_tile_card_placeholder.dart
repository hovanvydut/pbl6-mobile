import 'package:flutter/material.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:shimmer/shimmer.dart';

class PostListTileCardPlaceholder extends StatelessWidget {
  const PostListTileCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Card(
        color: context.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Shimmer.fromColors(
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
                            Shimmer.fromColors(
                              baseColor: kShimmerBaseColor,
                              highlightColor: kShimmerHightlightColor,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: kShimmerBaseColor,
                        highlightColor: kShimmerHightlightColor,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: kShimmerBaseColor,
                        highlightColor: kShimmerHightlightColor,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: kShimmerBaseColor,
                    highlightColor: kShimmerHightlightColor,
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
