import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_review_event.dart';
part 'create_review_state.dart';

class CreateReviewBloc extends Bloc<CreateReviewEvent, CreateReviewState> {
  CreateReviewBloc() : super(CreateReviewInitial()) {
    on<CreateReviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
