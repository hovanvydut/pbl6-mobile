import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
                color: Theme.of(context).colorScheme.onSurface,
                height: 32,
              ),
              onPressed: () => context.pop(),
            ),
            title: const Text('Đánh giá trọ'),
            centerTitle: true,
            actions: [
              Builder(
                builder: (context) {
                  final content = context
                      .select((CreateReviewBloc bloc) => bloc.state.content);
                  final imagePaths = context
                      .select((CreateReviewBloc bloc) => bloc.state.imagePaths);
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
                        : () => context
                            .read<CreateReviewBloc>()
                            .add(CreateReviewSubmitted()),
                  );
                },
              ),
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
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
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
                            color: Theme.of(context).colorScheme.onSurface,
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
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
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
