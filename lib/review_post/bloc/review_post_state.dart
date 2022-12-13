part of 'review_post_bloc.dart';

class ReviewUserPostState extends Equatable {
  const ReviewUserPostState({
    required this.post,
    this.postReviews = const [],
    this.currentPage = 1,
    this.reviewLoadingStatus = LoadingStatus.initial,
    this.reviewLoadingMoreStatus = LoadingStatus.initial,
    this.canLoadingMore = true,
    this.canReview = true,
  });

  final Post post;
  final List<Review> postReviews;
  final int currentPage;
  final LoadingStatus reviewLoadingStatus;
  final LoadingStatus reviewLoadingMoreStatus;
  final bool canLoadingMore;
  final bool canReview;

  @override
  List<Object?> get props => [
        post,
        reviewLoadingMoreStatus,
        reviewLoadingStatus,
        currentPage,
        postReviews,
        canLoadingMore,
        canReview
      ];

  ReviewUserPostState copyWith({
    Post? post,
    List<Review>? postReviews,
    int? currentPage,
    LoadingStatus? reviewLoadingStatus,
    LoadingStatus? reviewLoadingMoreStatus,
    bool? canReview,
    bool? canLoadingMore,
  }) {
    return ReviewUserPostState(
      post: post ?? this.post,
      postReviews: postReviews ?? this.postReviews,
      currentPage: currentPage ?? this.currentPage,
      reviewLoadingMoreStatus:
          reviewLoadingMoreStatus ?? this.reviewLoadingMoreStatus,
      reviewLoadingStatus: reviewLoadingStatus ?? this.reviewLoadingStatus,
      canLoadingMore: canLoadingMore ?? this.canLoadingMore,
      canReview: canReview ?? this.canReview,
    );
  }
}
