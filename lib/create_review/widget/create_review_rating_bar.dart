import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/create_review/create_review.dart';

class CreateReviewRatingBar extends StatelessWidget {
  const CreateReviewRatingBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<CreateReviewBloc, CreateReviewState>(
        builder: (context, state) {
          return RatingBar(
            itemSize: 54,
            itemCount: 4,
            ratingWidget: RatingWidget(
              full: Assets.icons.starBold.svg(color: Colors.yellow),
              half: const SizedBox(),
              empty: Assets.icons.starOutline
                  .svg(color: Theme.of(context).colorScheme.outline),
            ),
            initialRating: state.rating.toDouble(),
            onRatingUpdate: (value) =>
                context.read<CreateReviewBloc>().add(RatingUpdated(value)),
          );
        },
      ),
    );
  }
}
