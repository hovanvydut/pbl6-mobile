import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/create_review/create_review.dart';
import 'package:widgets/widgets.dart';

class ReviewContentPanel extends StatelessWidget {
  const ReviewContentPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mô tả chung',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: context.colorScheme.onSurface),
        ),
        const SizedBox(height: 16),
        Builder(
          builder: (context) {
            final content =
                context.select((CreateReviewBloc bloc) => bloc.state.content);
            return AppTextField(
              labelText: 'Cảm nghĩ của bạn',
              errorText: content.invalid
                  ? 'Cảm nghĩ của bạn không được để trống'
                  : null,
              onChanged: (content) =>
                  context.read<CreateReviewBloc>().add(ContentChanged(content)),
            );
          },
        ),
      ],
    );
  }
}
