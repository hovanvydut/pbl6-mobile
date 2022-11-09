part of 'create_review_bloc.dart';

class CreateReviewState extends Equatable {
  const CreateReviewState({
    required this.post,
    this.rating = 3,
    this.content = const Description.pure(),
    this.imagePaths = const [],
    this.createReviewStatus = LoadingStatus.initial,
  });

  final Post post;
  final int rating;
  final Description content;
  final List<String> imagePaths;
  final LoadingStatus createReviewStatus;
  @override
  List<Object?> get props => [
        post,
        rating,
        content,
        imagePaths,
        createReviewStatus,
      ];

  CreateReviewState copyWith({
    Post? post,
    int? rating,
    Description? content,
    List<String>? imagePaths,
    LoadingStatus? createReviewStatus,
  }) {
    return CreateReviewState(
      post: post ?? this.post,
      rating: rating ?? this.rating,
      content: content ?? this.content,
      imagePaths: imagePaths ?? this.imagePaths,
      createReviewStatus: createReviewStatus ?? this.createReviewStatus,
    );
  }
}
