import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/post/post.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required PostBloc postBloc,
  })  : _postBloc = postBloc,
        super(HomeInitial()) {
    on<HomePageStarted>(_onHomePageStarted);
    add(HomePageStarted());
  }

  final PostBloc _postBloc;

  void _onHomePageStarted(HomePageStarted event, Emitter<HomeState> emit) {
    _postBloc.add(GetAllPosts());
  }
}
