part of 'create_review_bloc.dart';

abstract class CreateReviewEvent extends Equatable {
  const CreateReviewEvent();

  @override
  List<Object?> get props => [];
}

class RatingUpdated extends CreateReviewEvent {
  const RatingUpdated(this.rating);

  final double rating;

  @override
  List<Object?> get props => [rating];
}

class ContentChanged extends CreateReviewEvent {
  const ContentChanged(this.content);

  final String content;

  @override
  List<Object?> get props => [content];
}

class MediaPressed extends CreateReviewEvent {
  const MediaPressed(this.imageSource);

  final ImageSource imageSource;

  @override
  List<Object?> get props => [imageSource];
}

class RemoveMediaPressed extends CreateReviewEvent {
  const RemoveMediaPressed(this.imagePath);

  final String imagePath;

  @override
  List<Object?> get props => [imagePath];
}

class CreateReviewSubmitted extends CreateReviewEvent {}
