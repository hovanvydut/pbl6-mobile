import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upload_post_event.dart';
part 'upload_post_state.dart';

class UploadPostBloc extends Bloc<UploadPostEvent, UploadPostState> {
  UploadPostBloc() : super(UploadPostInitial()) {
    on<UploadPostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
