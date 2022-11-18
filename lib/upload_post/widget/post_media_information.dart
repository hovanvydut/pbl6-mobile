import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/upload_post/upload_post.dart';
import 'package:platform_helper/platform_helper.dart';

class PostMediaInformation extends StatelessWidget {
  const PostMediaInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const box16 = SizedBox(height: 16);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Hình ảnh trọ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        BlocBuilder<UploadPostBloc, UploadPostState>(
          buildWhen: (previous, current) => previous.medias != current.medias,
          builder: (context, state) {
            final medias = state.medias;
            return medias.isEmpty
                ? box16
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SizedBox(
                      height: 120,
                      child: ListView.separated(
                        itemCount: medias.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final imagePath = medias[index];
                          return GestureDetector(
                            onTap: () => context.pushToViewImage(imagePath),
                            child: Container(
                              width: 150,
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
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                  onPressed: () => context
                                      .read<UploadPostBloc>()
                                      .add(MediaRemovePressed(imagePath)),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 16);
                        },
                      ),
                    ),
                  );
          },
        ),
        GestureDetector(
          onTap: () => context.read<UploadPostBloc>().add(MediaSelected()),
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
                  box16,
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
