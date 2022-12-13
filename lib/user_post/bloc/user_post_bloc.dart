import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:post/post.dart';

part 'user_post_event.dart';
part 'user_post_state.dart';

class UserPostBloc extends Bloc<UserPostEvent, UserPostState> {
  UserPostBloc({
    required PostRepository postRepository,
    required AuthenticationBloc authenticationBloc,
  })  : _postRepository = postRepository,
        _authenticationBloc = authenticationBloc,
        super(const UserPostState()) {
    on<GetUserPosts>(_onGetUserPosts);
    on<DeleteUserPost>(_onDeleteUserPost);
    on<GetMoreUserPosts>(_onGetMoreUserPosts);

    _authenticationBloc.stream.listen((state) {
      log(state.toString());
      if (state.user != null) {
        add(GetUserPosts());
      }
    });
  }

  final PostRepository _postRepository;
  final AuthenticationBloc _authenticationBloc;

  Future<void> _onGetUserPosts(
    GetUserPosts event,
    Emitter<UserPostState> emit,
  ) async {
    try {
      emit(state.copyWith(userPostsLoadingStatus: LoadingStatus.loading));
      final userPosts = await _postRepository.getUserPosts();
      emit(
        state.copyWith(
          userPostsLoadingStatus: LoadingStatus.done,
          userPostsData: userPosts,
          currentUserPostPage: state.currentUserPostPage + 1,
        ),
      );
    } catch (e) {
      emit(state.copyWith(userPostsLoadingStatus: LoadingStatus.error));
    }
  }

  Future<void> _onDeleteUserPost(
    DeleteUserPost event,
    Emitter<UserPostState> emit,
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

  Future<void> _onGetMoreUserPosts(
    GetMoreUserPosts event,
    Emitter<UserPostState> emit,
  ) async {
    try {
      if (!state.canUserPostsLoadMore) {
        return;
      }
      emit(state.copyWith(userPostsLoadMoreStatus: LoadingStatus.loading));
      final moreUserPosts = await _postRepository.getUserPosts(
        pageNumber: state.currentAllPostPage,
      );
      if (moreUserPosts.isNotEmpty) {
        emit(
          state.copyWith(
            userPostsLoadMoreStatus: LoadingStatus.done,
            userPostsData: [...state.userPostsData, ...moreUserPosts],
            currentUserPostPage: state.currentUserPostPage + 1,
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          userPostsLoadMoreStatus: LoadingStatus.done,
          canUserPostsLoadMore: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(userPostsLoadMoreStatus: LoadingStatus.error));
    }
  }
}
