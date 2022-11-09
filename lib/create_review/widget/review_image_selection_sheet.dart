import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/create_review/create_review.dart';
import 'package:platform_helper/platform_helper.dart';

class ReviewImageSelectionSheet extends StatelessWidget {
  const ReviewImageSelectionSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocListener<CreateReviewBloc, CreateReviewState>(
      listenWhen: (previous, current) =>
          previous.imagePaths != current.imagePaths,
      listener: (context, state) {
        Navigator.of(context).pop();
      },
      child: DecoratedBox(
        decoration: BoxDecoration(color: theme.colorScheme.surface),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Assets.icons.camera.svg(
                  color: theme.colorScheme.onSurface,
                ),
                title: Text(
                  'Chụp ảnh',
                  style: theme.textTheme.titleMedium,
                ),
                onTap: () => context
                    .read<CreateReviewBloc>()
                    .add(const MediaPressed(ImageSource.camera)),
              ),
              ListTile(
                leading: Assets.icons.gallery.svg(
                  color: theme.colorScheme.onSurface,
                ),
                title: Text(
                  'Từ thư viện',
                  style: theme.textTheme.titleMedium,
                ),
                onTap: () => context
                    .read<CreateReviewBloc>()
                    .add(const MediaPressed(ImageSource.gallery)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
