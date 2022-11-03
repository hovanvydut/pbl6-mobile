import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:post/post.dart';

part 'detail_host_state.dart';

class DetailHostCubit extends Cubit<DetailHostState> {
  DetailHostCubit({required User host, required PostRepository postRepository})
      : _postRepository = postRepository,
        super(DetailHostState(host: host));

  final PostRepository _postRepository;
}
