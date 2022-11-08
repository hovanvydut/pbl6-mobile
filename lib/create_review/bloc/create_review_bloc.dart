import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media/media.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:review/review.dart';

part 'create_review_event.dart';
part 'create_review_state.dart';

class CreateReviewBloc extends Bloc<CreateReviewEvent, CreateReviewState> {
  CreateReviewBloc({
    required Post post,
    required ReviewRepository reviewRepository,
    required MediaRepository mediaRepository,
  })  : _reviewRepository = reviewRepository,
        _mediaRepository = mediaRepository,
        super(CreateReviewState(post: post)) {
    on<RatingUpdated>(_onRatingUpdated);
    on<ContentChanged>(_onContentChanged);
    on<MediaPressed>(_onMediaPressed);
    on<RemoveMediaPressed>(_onRemoveMediaPressed);
    on<CreateReviewSubmitted>(_onSubmitted);
  }

  final ReviewRepository _reviewRepository;
  final MediaRepository _mediaRepository;

  void _onRatingUpdated(
    RatingUpdated event,
    Emitter<CreateReviewState> emit,
  ) {
    emit(state.copyWith(rating: event.rating.toInt()));
  }

  void _onContentChanged(
    ContentChanged event,
    Emitter<CreateReviewState> emit,
  ) {
    final content = Description.dirty(event.content);
    emit(
      state.copyWith(content: content),
    );
  }

  Future<void> _onMediaPressed(
    MediaPressed event,
    Emitter<CreateReviewState> emit,
  ) async {
    final pickedImage =
        await ImagePickerHelper.pickImageFromSource(event.imageSource);
    if (pickedImage != null) {
      emit(state.copyWith(imagePaths: [...state.imagePaths, pickedImage]));
    }
  }

  void _onRemoveMediaPressed(
    RemoveMediaPressed event,
    Emitter<CreateReviewState> emit,
  ) {
    emit(
      state.copyWith(
        imagePaths: state.imagePaths
            .where((imagePath) => imagePath != event.imagePath)
            .toList(),
      ),
    );
  }

  Future<void> _onSubmitted(
    CreateReviewSubmitted event,
    Emitter<CreateReviewState> emit,
  ) async {
    try {
      emit(state.copyWith(createReviewStatus: LoadingStatus.loading));
      final uploadedImages = <String>[];
      for (final imagePath in state.imagePaths) {
        final uploadedUrl = await _mediaRepository.uploadImage(imagePath);
        uploadedImages.add(uploadedUrl);
      }
      final mediaData = uploadedImages.map((url) => Media(url: url)).toList();
      await _reviewRepository.createReview(
        content: state.content.value,
        medias: mediaData,
        postId: state.post.id,
        rating: state.rating,
      );
      emit(state.copyWith(createReviewStatus: LoadingStatus.done));
    } catch (e) {
      addError(e);
      emit(state.copyWith(createReviewStatus: LoadingStatus.error));
      rethrow;
    }
  }
}
