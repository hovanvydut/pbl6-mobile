import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/create_review/create_review.dart';

class CreateReviewSaveButton extends StatelessWidget {
  const CreateReviewSaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final content =
            context.select((CreateReviewBloc bloc) => bloc.state.content);
        final imagePaths =
            context.select((CreateReviewBloc bloc) => bloc.state.imagePaths);
        final valid = content.valid && imagePaths.isNotEmpty;
        return IconButton(
          icon: Assets.icons.save.svg(
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withOpacity(valid ? 1 : 0.38),
            height: 28,
          ),
          onPressed: !valid
              ? null
              : () =>
                  context.read<CreateReviewBloc>().add(CreateReviewSubmitted()),
        );
      },
    );
  }
}
