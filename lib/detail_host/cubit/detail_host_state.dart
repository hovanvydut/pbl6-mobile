part of 'detail_host_cubit.dart';

class DetailHostState extends Equatable {
  const DetailHostState({
    required this.host,
    this.hostPosts = const [],
    this.loadingStatus = LoadingStatus.initial,
  });

  final User host;
  final List<Post> hostPosts;
  final LoadingStatus loadingStatus;

  @override
  List<Object?> get props => [host, hostPosts, loadingStatus];

  DetailHostState copyWith({
    User? host,
    List<Post>? hostPosts,
    LoadingStatus? loadingStatus,
  }) {
    return DetailHostState(
      host: host ?? this.host,
      hostPosts: hostPosts ?? this.hostPosts,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
