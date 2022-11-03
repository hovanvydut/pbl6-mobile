part of 'detail_post_cubit.dart';

class DetailPostState extends Equatable {
  const DetailPostState({
    required this.post,
    this.loadingStatus = LoadingStatus.initial,
  });

  final Post post;
  final LoadingStatus loadingStatus;

  @override
  List<Object?> get props => [post, loadingStatus];

  DetailPostState copyWith({
    Post? post,
    LoadingStatus? loadingStatus,
  }) {
    return DetailPostState(
      post: post ?? this.post,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
