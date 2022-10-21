import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/upload_post/upload_post.dart';

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
        BlocBuilder<UploadPostBloc, UploadPostState>(
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
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        File(media),
                                        fit: BoxFit.cover,
                                        height: 120,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Assets.icons.close.svg(),
                                onPressed: () => context
                                    .read<UploadPostBloc>()
                                    .add(MediaRemovePressed(media)),
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
