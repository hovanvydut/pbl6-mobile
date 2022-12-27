import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/l10n/l10n.dart';
import 'package:pbl6_mobile/review_post/review_post.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:review/review.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class ReviewPostSession extends StatelessWidget {
  const ReviewPostSession({super.key, required this.post});

  final Post post;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewUserPostBloc(
        post: post,
        reviewRepository: context.read<ReviewRepository>(),
        authenticationBloc: context.read<AuthenticationBloc>(),
      ),
      child: const ReviewPostView(),
    );
  }
}

class ReviewPostView extends StatelessWidget {
  const ReviewPostView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Đánh giá',
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            Builder(
              builder: (context) {
                final reviews = context.select(
                  (ReviewUserPostBloc bloc) => bloc.state.postReviews,
                );
                final user = context.watch<AuthenticationBloc>().state.user;
                final post = context
                    .select((ReviewUserPostBloc bloc) => bloc.state.post);
                final canReview = context
                    .select((ReviewUserPostBloc bloc) => bloc.state.canReview);
                return Visibility(
                  visible:
                      reviews.isNotEmpty && post.authorInfo!.id != user?.id,
                  child: TextButton(
                    child: const Text('Thêm đánh giá'),
                    onPressed: () {
                      if (canReview) {
                        context.pushToChild(
                          AppRouter.createReview,
                          extra: ExtraParams2<Post, ReviewUserPostBloc>(
                            param1:
                                context.read<ReviewUserPostBloc>().state.post,
                            param2: context.read<ReviewUserPostBloc>(),
                          ),
                        );
                        return;
                      }
                      ToastHelper.showToast(
                        'Bạn chưa đủ điều kiện để đánh giá bài đăng này',
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        Builder(
          builder: (context) {
            final reviewLoadingStatus = context.select(
              (ReviewUserPostBloc bloc) => bloc.state.reviewLoadingStatus,
            );
            final reviews = context
                .select((ReviewUserPostBloc bloc) => bloc.state.postReviews);
            final loadingMoreStatus = context.select(
              (ReviewUserPostBloc bloc) => bloc.state.reviewLoadingMoreStatus,
            );
            final canLoadingMore = context.select(
              (ReviewUserPostBloc bloc) => bloc.state.canLoadingMore,
            );

            final post =
                context.select((ReviewUserPostBloc bloc) => bloc.state.post);
            if (reviewLoadingStatus == LoadingStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (reviewLoadingStatus == LoadingStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Assets.images.errorNotFound.svg(
                      height: 100,
                      width: 150,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Có lỗi xảy ra vui lòng thử lại',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    )
                  ],
                ),
              );
            }
            if (reviews.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Chưa có đánh giá nào cho bài viết này',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        final user =
                            context.watch<AuthenticationBloc>().state.user;
                        final canReview = context.select(
                          (ReviewUserPostBloc bloc) => bloc.state.canReview,
                        );
                        if (post.authorInfo!.id != user?.id) {
                          return TextButton(
                            onPressed: user?.id == null
                                ? () {
                                    ToastHelper.showToast(
                                      'Bạn phải đăng nhập '
                                      'để thực hiện hành động này',
                                    );
                                    context.push(AppRouter.login);
                                  }
                                : () {
                                    if (canReview) {
                                      context.pushToChild(
                                        AppRouter.createReview,
                                        extra: ExtraParams2<Post,
                                            ReviewUserPostBloc>(
                                          param1: context
                                              .read<ReviewUserPostBloc>()
                                              .state
                                              .post,
                                          param2: context
                                              .read<ReviewUserPostBloc>(),
                                        ),
                                      );
                                      return;
                                    }
                                    ToastHelper.showToast(
                                      'Bạn chưa đủ điều kiện để '
                                      'đánh giá bài đăng này',
                                    );
                                  },
                            child: const Text('Hãy là người đầu tiền đánh giá'),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  '${post.averageRating?.toStringAsFixed(1)}/4',
                  style: theme.textTheme.titleLarge!
                      .copyWith(color: theme.colorScheme.primary),
                ),
                const SizedBox(height: 16),
                ...reviews.map(
                  (review) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: review.userInfo.avatar ??
                                  'https://avatars.githubusercontent.com/u/63831488?v=4',
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 24,
                                backgroundImage: imageProvider,
                              ),
                              placeholder: (context, url) => CircleAvatar(
                                radius: 24,
                                backgroundColor: theme.colorScheme.surface,
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                radius: 24,
                                backgroundColor: theme.colorScheme.surface,
                                child: Assets.icons.danger.svg(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    review.userInfo.displayName,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  RatingBar(
                                    itemCount: 4,
                                    initialRating: review.rating.toDouble(),
                                    ratingWidget: RatingWidget(
                                      empty: Assets.icons.starOutline
                                          .svg(color: Colors.yellow),
                                      full: Assets.icons.starBold
                                          .svg(color: Colors.yellow),
                                      half: const SizedBox(),
                                    ),
                                    itemSize: 20,
                                    ignoreGestures: true,
                                    onRatingUpdate: (_) {},
                                  ),
                                  const SizedBox(height: 8),
                                  Timeago(
                                    locale: context.l10n.localeName,
                                    date: review.createdAt,
                                    builder: (_, timeago) {
                                      return Text(
                                        timeago,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          review.content,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                            if (review.sentiment != null)
                              SentimentIllustrator(
                                sentiment: review.sentiment!,
                              )
                          ],
                        ),
                        SizedBox(
                          height: review.medias.isEmpty ? 0 : 150,
                          child: ListView.separated(
                            itemCount: review.medias.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final media = review.medias[index];
                              return CachedNetworkImage(
                                imageUrl: media.url,
                                imageBuilder: (context, imageProvider) =>
                                    GestureDetector(
                                  onTap: () =>
                                      context.pushToViewImage(media.url),
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => const SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          Assets.images.notImage.image().image,
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
                        if (reviews.indexOf(review) < reviews.length - 1)
                          const Divider(
                            height: 32,
                          )
                      ],
                    );
                  },
                ).toList(),
                if (loadingMoreStatus == LoadingStatus.loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else if (canLoadingMore)
                  Center(
                    child: TextButton(
                      child: const Text('Xem thêm đánh giá'),
                      onPressed: () => context
                          .read<ReviewUserPostBloc>()
                          .add(LoadingMorePressed()),
                    ),
                  )
                else
                  const SizedBox(
                    height: 8,
                  )
              ],
            );
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
