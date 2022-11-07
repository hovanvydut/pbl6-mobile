import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'review_post_event.dart';
part 'review_post_state.dart';

class ReviewPostBloc extends Bloc<ReviewPostEvent, ReviewPostState> {
  ReviewPostBloc() : super(ReviewPostInitial()) {
    on<ReviewPostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
