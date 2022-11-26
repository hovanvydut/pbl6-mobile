import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/create_review/create_review.dart';
import 'package:platform_helper/platform_helper.dart';

class CreateReviewImagePanel extends StatelessWidget {
  const CreateReviewImagePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thêm hình ảnh',
          style: context.textTheme.titleLarge!.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),
        Builder(
          builder: (context) {
            final imagePaths = context.select(
              (CreateReviewBloc bloc) => bloc.state.imagePaths,
            );
            if (imagePaths.isEmpty) {
              return const SizedBox(height: 16);
            }
            return SizedBox(
              height: 200,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: imagePaths.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final imagePath = imagePaths[index];
                  return GestureDetector(
                    onTap: () => context.pushToViewImage(imagePath),
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AdaptiveImageProvider(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(4),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.5),
                        child: IconButton(
                          icon: Assets.icons.close.svg(
                            color: context.colorScheme.onSurface,
                          ),
                          onPressed: () => context
                              .read<CreateReviewBloc>()
                              .add(RemoveMediaPressed(imagePath)),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 16);
                },
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<CreateReviewBloc>(),
                  child: const ReviewImageSelectionSheet(),
                );
              },
            );
          },
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(16),
            dashPattern: const [10, 4],
            strokeCap: StrokeCap.round,
            color: context.colorScheme.primary,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
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
                    style: context.textTheme.bodyMedium,
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
