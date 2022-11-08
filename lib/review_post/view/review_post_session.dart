import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/review_post/review_post.dart';
import 'package:review/review.dart';

class ReviewPostSession extends StatelessWidget {
  const ReviewPostSession({super.key, required this.post});

  final Post post;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewPostBloc(
        post: post,
        reviewRepository: context.read<ReviewRepository>(),
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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Builder(
              builder: (context) {
                final reviews = context
                    .select((ReviewPostBloc bloc) => bloc.state.postReviews);
                return Visibility(
                  visible: reviews.isNotEmpty,
                  child: TextButton(
                    child: const Text('Thêm đánh giá'),
                    onPressed: () =>
                        context.pushToChild(AppRouter.createReview),
                  ),
                );
              },
            ),
          ],
        ),
        Builder(
          builder: (context) {
            final reviewLoadingStatus = context.select(
              (ReviewPostBloc bloc) => bloc.state.reviewLoadingStatus,
            );
            final reviews =
                context.select((ReviewPostBloc bloc) => bloc.state.postReviews);
            final loadingMoreStatus = context.select(
              (ReviewPostBloc bloc) => bloc.state.reviewLoadingMoreStatus,
            );
            final canLoadingMore = context.select(
              (ReviewPostBloc bloc) => bloc.state.canLoadingMore,
            );
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
                    Assets.images.errorNotFound.svg(
                      height: 100,
                      width: 150,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Có lỗi xảy ra vui lòng thử lại',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
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
                      height: 12,
                    ),
                    Text(
                      'Chưa có đánh giá nào cho bài viết này',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    TextButton(
                      child: const Text('Hãy là người đầu tiền đánh giá'),
                      onPressed: () =>
                          context.pushToChild(AppRouter.createReview),
                    ),
                  ],
                ),
              );
            }
            return Column(
              children: [
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.userInfo.displayName,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                RatingBar(
                                  initialRating: review.rating.toDouble(),
                                  ratingWidget: RatingWidget(
                                    empty: Assets.icons.starOutline
                                        .svg(color: Colors.yellow),
                                    full: Assets.icons.starBold
                                        .svg(color: Colors.yellow),
                                    half: const SizedBox(),
                                  ),
                                  itemSize: 20,
                                  onRatingUpdate: (_) {},
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  review.createdAt.timeAgo,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  review.content,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 150,
                          child: ListView.separated(
                            itemCount: review.medias.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final media = review.medias[index];
                              return CachedNetworkImage(
                                imageUrl: media.url,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
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
                  TextButton(
                    child: const Text('Xem thêm đánh giá'),
                    onPressed: () => context
                        .read<ReviewPostBloc>()
                        .add(LoadingMorePressed()),
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