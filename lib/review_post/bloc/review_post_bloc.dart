import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:review/review.dart';

part 'review_post_event.dart';
part 'review_post_state.dart';

class ReviewPostBloc extends Bloc<ReviewPostEvent, ReviewPostState> {
  ReviewPostBloc({
    required Post post,
    required ReviewRepository reviewRepository,
  })  : _reviewRepository = reviewRepository,
        super(ReviewPostState(post: post)) {
    on<DetailPostStarted>(_onDetailPostStarted);
    on<LoadingMorePressed>(_onLoadingMorePressed);
    add(DetailPostStarted());
  }

  final ReviewRepository _reviewRepository;

  Future<void> _onDetailPostStarted(
    DetailPostStarted event,
    Emitter<ReviewPostState> emit,
  ) async {
    try {
      emit(state.copyWith(reviewLoadingStatus: LoadingStatus.loading));
      final reviews = await _reviewRepository.getReviewsByPostId(state.post.id);
      emit(
        state.copyWith(
          reviewLoadingStatus: LoadingStatus.done,
          postReviews: reviews,
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
    Emitter<ReviewPostState> emit,
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
}
