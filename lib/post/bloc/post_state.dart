part of 'post_bloc.dart';

class PostState extends Equatable {
  const PostState({
    this.userPostsData = const <Post>[],
    this.allPostsData = const <Post>[],
    this.userPostsLoadingStatus = LoadingStatus.initial,
    this.allPostsLoadingStatus = LoadingStatus.initial,
    this.deletePostStatus = LoadingStatus.initial,
  });

  final List<Post> userPostsData;
  final List<Post> allPostsData;
  final LoadingStatus userPostsLoadingStatus;
  final LoadingStatus allPostsLoadingStatus;
  final LoadingStatus deletePostStatus;

  @override
  List<Object> get props {
    return [
      userPostsData,
      allPostsData,
      userPostsLoadingStatus,
      allPostsLoadingStatus,
      deletePostStatus,
    ];
  }

  PostState copyWith({
    List<Post>? userPostsData,
    List<Post>? allPostsData,
    LoadingStatus? userPostsLoadingStatus,
    LoadingStatus? allPostsLoadingStatus,
    LoadingStatus? deletePostStatus,
  }) {
    return PostState(
      userPostsData: userPostsData ?? this.userPostsData,
      allPostsData: allPostsData ?? this.allPostsData,
      userPostsLoadingStatus:
          userPostsLoadingStatus ?? this.userPostsLoadingStatus,
      allPostsLoadingStatus:
          allPostsLoadingStatus ?? this.allPostsLoadingStatus,
      deletePostStatus: deletePostStatus ?? this.deletePostStatus,
    );
  }
}
