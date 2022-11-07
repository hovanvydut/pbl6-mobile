import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:post/post.dart';

part 'detail_host_state.dart';

class DetailHostCubit extends Cubit<DetailHostState> {
  DetailHostCubit({required User host, required PostRepository postRepository})
      : _postRepository = postRepository,
        super(DetailHostState(host: host)) {
    getPostsOfHost();
  }

  final PostRepository _postRepository;

  Future<void> getPostsOfHost() async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final hostPosts = await _postRepository.getPostsByHostId(state.host.id);
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.done,
          hostPosts: hostPosts,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
      rethrow;
    }
  }
}
