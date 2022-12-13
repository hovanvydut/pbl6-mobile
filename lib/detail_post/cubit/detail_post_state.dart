part of 'detail_post_cubit.dart';

class DetailUserPostState extends Equatable {
  const DetailUserPostState({
    required this.post,
    this.loadingStatus = LoadingStatus.initial,
  });

  final Post post;
  final LoadingStatus loadingStatus;

  @override
  List<Object?> get props => [post, loadingStatus];

  DetailUserPostState copyWith({
    Post? post,
    LoadingStatus? loadingStatus,
  }) {
    return DetailUserPostState(
      post: post ?? this.post,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
