part of 'detail_post_cubit.dart';

class DetailUserPostState extends Equatable {
  const DetailUserPostState({
    required this.post,
    this.loadingStatus = LoadingStatus.initial,
    this.relatedPostLoadingStatus = LoadingStatus.initial,
    this.relatedPosts = const <Post>[],
  });

  final Post post;
  final LoadingStatus loadingStatus;
  final LoadingStatus relatedPostLoadingStatus;
  final List<Post> relatedPosts;

  @override
  List<Object?> get props => [
        post,
        loadingStatus,
        relatedPostLoadingStatus,
        relatedPosts,
      ];

  DetailUserPostState copyWith({
    Post? post,
    LoadingStatus? loadingStatus,
    LoadingStatus? relatedPostLoadingStatus,
    List<Post>? relatedPosts,
  }) {
    return DetailUserPostState(
      post: post ?? this.post,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      relatedPostLoadingStatus:
          relatedPostLoadingStatus ?? this.relatedPostLoadingStatus,
      relatedPosts: relatedPosts ?? this.relatedPosts,
    );
  }
}
