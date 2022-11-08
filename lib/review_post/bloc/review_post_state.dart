part of 'review_post_bloc.dart';

class ReviewPostState extends Equatable {
  const ReviewPostState({
    required this.post,
    this.postReviews = const [],
    this.currentPage = 1,
    this.reviewLoadingStatus = LoadingStatus.initial,
    this.reviewLoadingMoreStatus = LoadingStatus.initial,
    this.canLoadingMore = true,
  });

  final Post post;
  final List<Review> postReviews;
  final int currentPage;
  final LoadingStatus reviewLoadingStatus;
  final LoadingStatus reviewLoadingMoreStatus;
  final bool canLoadingMore;

  @override
  List<Object?> get props => [
        post,
        reviewLoadingMoreStatus,
        reviewLoadingStatus,
        currentPage,
        postReviews,
        canLoadingMore,
      ];

  ReviewPostState copyWith({
    Post? post,
    List<Review>? postReviews,
    int? currentPage,
    LoadingStatus? reviewLoadingStatus,
    LoadingStatus? reviewLoadingMoreStatus,
    bool? canLoadingMore,
  }) {
    return ReviewPostState(
      post: post ?? this.post,
      postReviews: postReviews ?? this.postReviews,
      currentPage: currentPage ?? this.currentPage,
      reviewLoadingMoreStatus:
          reviewLoadingMoreStatus ?? this.reviewLoadingMoreStatus,
      reviewLoadingStatus: reviewLoadingStatus ?? this.reviewLoadingStatus,
      canLoadingMore: canLoadingMore ?? this.canLoadingMore,
    );
  }
}
