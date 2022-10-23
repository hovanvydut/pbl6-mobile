import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/edit_post/edit_post.dart';
import 'package:platform_helper/platform_helper.dart';

class EditingMediaInformation extends StatelessWidget {
  const EditingMediaInformation({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Hình ảnh trọ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        BlocBuilder<EditPostBloc, EditPostState>(
          buildWhen: (previous, current) => previous.medias != current.medias,
          builder: (context, state) {
            final medias = state.medias;
            return medias.isEmpty
                ? const SizedBox(
                    height: 16,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SizedBox(
                      height: 130,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: medias.length,
                        itemBuilder: (context, index) {
                          final media = medias[index];
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              SizedBox(
                                width: 130,
                                child: Card(
                                  color: theme.colorScheme.surface,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image(
                                        image: AdaptiveImageProvider(media),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Assets.icons.close.svg(
                                  color: theme.colorScheme.onSurface,
                                ),
                                onPressed: () =>
                                    context.read<EditPostBloc>().add(
                                          MediaRemovePressed(media),
                                        ),
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 8,
                          );
                        },
                      ),
                    ),
                  );
          },
        ),
        GestureDetector(
          onTap: () => context.read<EditPostBloc>().add(MediaSelected()),
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
