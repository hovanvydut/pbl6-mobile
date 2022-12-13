part of 'user_post_bloc.dart';

class UserPostState extends Equatable {
  const UserPostState({
    this.userPostsData = const <Post>[],
    this.allPostsData = const <Post>[],
    this.userPostsLoadingStatus = LoadingStatus.initial,
    this.allPostsLoadingStatus = LoadingStatus.initial,
    this.deletePostStatus = LoadingStatus.initial,
    this.userPostsLoadMoreStatus = LoadingStatus.initial,
    this.allPostsLoadMoreStatus = LoadingStatus.initial,
    this.currentAllPostPage = 1,
    this.currentUserPostPage = 1,
    this.canUserPostsLoadMore = true,
  });

  final List<Post> userPostsData;
  final List<Post> allPostsData;
  final LoadingStatus userPostsLoadingStatus;
  final LoadingStatus userPostsLoadMoreStatus;
  final LoadingStatus allPostsLoadingStatus;
  final LoadingStatus allPostsLoadMoreStatus;
  final LoadingStatus deletePostStatus;
  final int currentAllPostPage;
  final int currentUserPostPage;
  final bool canUserPostsLoadMore;

  @override
  List<Object> get props {
    return [
      userPostsData,
      allPostsData,
      userPostsLoadingStatus,
      userPostsLoadMoreStatus,
      allPostsLoadingStatus,
      allPostsLoadMoreStatus,
      deletePostStatus,
      currentAllPostPage,
      currentUserPostPage,
      canUserPostsLoadMore,
    ];
  }

  UserPostState copyWith({
    List<Post>? userPostsData,
    List<Post>? allPostsData,
    LoadingStatus? userPostsLoadingStatus,
    LoadingStatus? userPostsLoadMoreStatus,
    LoadingStatus? allPostsLoadingStatus,
    LoadingStatus? allPostsLoadMoreStatus,
    LoadingStatus? deletePostStatus,
    int? currentAllPostPage,
    int? currentUserPostPage,
    bool? canUserPostsLoadMore,
  }) {
    return UserPostState(
      userPostsData: userPostsData ?? this.userPostsData,
      allPostsData: allPostsData ?? this.allPostsData,
      userPostsLoadingStatus:
          userPostsLoadingStatus ?? this.userPostsLoadingStatus,
      userPostsLoadMoreStatus:
          userPostsLoadMoreStatus ?? this.userPostsLoadMoreStatus,
      allPostsLoadingStatus:
          allPostsLoadingStatus ?? this.allPostsLoadingStatus,
      allPostsLoadMoreStatus:
          allPostsLoadMoreStatus ?? this.allPostsLoadMoreStatus,
      deletePostStatus: deletePostStatus ?? this.deletePostStatus,
      currentAllPostPage: currentAllPostPage ?? this.currentAllPostPage,
      currentUserPostPage: currentUserPostPage ?? this.currentUserPostPage,
      canUserPostsLoadMore: canUserPostsLoadMore ?? this.canUserPostsLoadMore,
    );
  }
}
