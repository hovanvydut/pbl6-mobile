import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:pbl6_mobile/app/app.dart';

class PostMediaInformation extends StatelessWidget {
  const PostMediaInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const box16 = SizedBox(
      height: 16,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Hình ảnh trọ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        box16,
        GestureDetector(
          onTap: () {},
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            dashPattern: const [10, 4],
            strokeCap: StrokeCap.round,
            color: Theme.of(context).colorScheme.primary,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.uploadCloud.svg(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Chọn ảnh của bạn',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
