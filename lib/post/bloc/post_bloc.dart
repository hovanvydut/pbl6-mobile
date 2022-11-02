import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:post/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({
    required PostRepository postRepository,
    required AuthenticationBloc authenticationBloc,
  })  : _postRepository = postRepository,
        _authenticationBloc = authenticationBloc,
        super(const PostState()) {
    on<GetAllPosts>(_onGetAllPosts);
    on<GetUserPosts>(_onGetUserPosts);
    on<DeleteUserPost>(_onDeleteUserPost);
    _authenticationBloc.stream.listen((state) {
      if (state.user != null) {
        add(GetUserPosts());
      }
    });
    // add(GetAllPosts());
  }

  final PostRepository _postRepository;
  final AuthenticationBloc _authenticationBloc;

  Future<void> _onGetAllPosts(
    GetAllPosts event,
    Emitter<PostState> emit,
  ) async {
    try {
      emit(state.copyWith(allPostsLoadingStatus: LoadingStatus.loading));
      final allPosts = await _postRepository.getAllPosts();
      emit(
        state.copyWith(
          allPostsLoadingStatus: LoadingStatus.done,
          allPostsData: allPosts,
        ),
      );
    } catch (e) {
      emit(state.copyWith(allPostsLoadingStatus: LoadingStatus.error));
    }
  }

  Future<void> _onGetUserPosts(
    GetUserPosts event,
    Emitter<PostState> emit,
  ) async {
    try {
      emit(state.copyWith(userPostsLoadingStatus: LoadingStatus.loading));
      final userPosts = await _postRepository.getUserPosts();
      emit(
        state.copyWith(
          userPostsLoadingStatus: LoadingStatus.done,
          userPostsData: userPosts,
        ),
      );
    } catch (e) {
      emit(state.copyWith(userPostsLoadingStatus: LoadingStatus.error));
    }
  }

  Future<void> _onDeleteUserPost(
    DeleteUserPost event,
    Emitter<PostState> emit,
  ) async {
    try {
      emit(state.copyWith(deletePostStatus: LoadingStatus.loading));
      await _postRepository.deletePost(event.post.id);
      emit(
        state.copyWith(
          deletePostStatus: LoadingStatus.done,
          userPostsData:
              state.userPostsData.where((post) => post != event.post).toList(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          deletePostStatus: LoadingStatus.error,
        ),
      );
    }
  }
}
