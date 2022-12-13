part of 'review_post_bloc.dart';

abstract class ReviewPostEvent extends Equatable {
  const ReviewPostEvent();

  @override
  List<Object?> get props => [];
}

class DetailPostStarted extends ReviewPostEvent {}

class CheckReviewPost extends ReviewPostEvent {}

class LoadingMorePressed extends ReviewPostEvent {}
