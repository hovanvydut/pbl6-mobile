import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:post/post.dart';

part 'detail_post_state.dart';

class DetailPostCubit extends Cubit<DetailUserPostState> {
  DetailPostCubit({required Post post, required PostRepository postRepository})
      : _postRepository = postRepository,
        super(DetailUserPostState(post: post)) {
    getDetailPost();
  }

  final PostRepository _postRepository;

  Future<void> getDetailPost() async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final detailPost = await _postRepository.getDetailPostById(state.post.id);
      emit(state.copyWith(loadingStatus: LoadingStatus.done, post: detailPost));
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
      rethrow;
    }
  }
}
