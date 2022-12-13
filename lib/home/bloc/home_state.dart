part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.district = const [],
    this.allPosts = const [],
    this.homeLoadingStatus = LoadingStatus.initial,
    this.loadMorePostStatus = LoadingStatus.initial,
    this.canAllPostsLoadMore = true,
    this.currentPage = 1,
  });

  final List<District> district;
  final List<Post> allPosts;
  final LoadingStatus homeLoadingStatus;
  final LoadingStatus loadMorePostStatus;
  final bool canAllPostsLoadMore;
  final int currentPage;

  @override
  List<Object> get props {
    return [
      district,
      allPosts,
      homeLoadingStatus,
      loadMorePostStatus,
      canAllPostsLoadMore,
      currentPage,
    ];
  }

  HomeState copyWith({
    List<District>? district,
    List<Post>? allPosts,
    LoadingStatus? homeLoadingStatus,
    LoadingStatus? loadMorePostStatus,
    bool? canAllPostsLoadMore,
    int? currentPage,
  }) {
    return HomeState(
      district: district ?? this.district,
      allPosts: allPosts ?? this.allPosts,
      homeLoadingStatus: homeLoadingStatus ?? this.homeLoadingStatus,
      loadMorePostStatus: loadMorePostStatus ?? this.loadMorePostStatus,
      canAllPostsLoadMore: canAllPostsLoadMore ?? this.canAllPostsLoadMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
