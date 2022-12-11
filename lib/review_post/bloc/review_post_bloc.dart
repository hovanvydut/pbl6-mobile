import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:review/review.dart';

part 'review_post_event.dart';
part 'review_post_state.dart';

class ReviewUserPostBloc extends Bloc<ReviewPostEvent, ReviewUserPostState> {
  ReviewUserPostBloc({
    required Post post,
    required ReviewRepository reviewRepository,
    required AuthenticationBloc authenticationBloc,
  })  : _reviewRepository = reviewRepository,
        _authenticationBloc = authenticationBloc,
        super(ReviewUserPostState(post: post)) {
    on<DetailPostStarted>(_onDetailPostStarted);
    on<CheckReviewPost>(_onCheckReviewPost);

    on<LoadingMorePressed>(_onLoadingMorePressed);
    add(DetailPostStarted());
  }

  final ReviewRepository _reviewRepository;
  final AuthenticationBloc _authenticationBloc;

  Future<void> _onDetailPostStarted(
    DetailPostStarted event,
    Emitter<ReviewUserPostState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          reviewLoadingStatus: LoadingStatus.loading,
          currentPage: 1,
        ),
      );
      if (_authenticationBloc.state.user != null) {
        add(CheckReviewPost());
      }

      final reviews = await _reviewRepository.getReviewsByPostId(state.post.id);

      emit(
        state.copyWith(
          reviewLoadingStatus: LoadingStatus.done,
          postReviews: reviews,
          canLoadingMore: reviews.length > 1,
          currentPage: state.currentPage + 1,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(reviewLoadingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onLoadingMorePressed(
    LoadingMorePressed event,
    Emitter<ReviewUserPostState> emit,
  ) async {
    try {
      emit(state.copyWith(reviewLoadingMoreStatus: LoadingStatus.loading));
      final moreReviews = await _reviewRepository.getReviewsByPostId(
        state.post.id,
        pageNumber: state.currentPage,
      );
      if (moreReviews.isEmpty || moreReviews.length < 5) {
        emit(
          state.copyWith(
            reviewLoadingMoreStatus: LoadingStatus.done,
            postReviews: [...state.postReviews, ...moreReviews],
            canLoadingMore: false,
          ),
        );
        return;
      } else {
        emit(
          state.copyWith(
            reviewLoadingMoreStatus: LoadingStatus.done,
            postReviews: [...state.postReviews, ...moreReviews],
            currentPage: state.currentPage + 1,
          ),
        );
      }
    } catch (e) {
      addError(e);
      emit(state.copyWith(reviewLoadingMoreStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onCheckReviewPost(
    CheckReviewPost event,
    Emitter<ReviewUserPostState> emit,
  ) async {
    try {
      final canReview =
          await _reviewRepository.checkReviewPost(postId: state.post.id);
      emit(state.copyWith(canReview: canReview));
    } catch (e) {
      addError(e);
      rethrow;
    }
  }
}
