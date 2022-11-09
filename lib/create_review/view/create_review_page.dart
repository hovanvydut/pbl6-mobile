import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:media/media.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/create_review/create_review.dart';
import 'package:pbl6_mobile/review_post/review_post.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:review/review.dart';
import 'package:widgets/widgets.dart';

class CreateReviewPage extends StatelessWidget {
  const CreateReviewPage({super.key, required this.post});

  final Post post;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateReviewBloc(
        post: post,
        mediaRepository: context.read<MediaRepository>(),
        reviewRepository: context.read<ReviewRepository>(),
      ),
      child: const CreateReviewView(),
    );
  }
}

class CreateReviewView extends StatelessWidget {
  const CreateReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateReviewBloc, CreateReviewState>(
      listenWhen: (previous, current) =>
          previous.createReviewStatus != current.createReviewStatus,
      listener: (context, state) {
        if (state.createReviewStatus == LoadingStatus.done) {
          ToastHelper.showToast('Cảm ơn bạn đã đánh giá');
          context.pop();
          context.read<ReviewPostBloc>().add(DetailPostStarted());
        }
        if (state.createReviewStatus == LoadingStatus.error) {
          context.showSnackBar(
            message: 'Đánh giá không thành công, xin thử lại',
          );
        }
      },
      child: DismissFocus(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Assets.icons.arrorLeft.svg(
                color: context.colorScheme.onSurface,
                height: 32,
              ),
              onPressed: () => context.pop(),
            ),
            title: const Text('Đánh giá trọ'),
            centerTitle: true,
            actions: const [
              CreateReviewSaveButton(),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Spacer(),
                CreateReviewRatingBar(),
                Spacer(),
                ReviewContentPanel(),
                SizedBox(height: 40),
                CreateReviewImagePanel(),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
