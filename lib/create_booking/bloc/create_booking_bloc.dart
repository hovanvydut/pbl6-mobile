import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_booking_event.dart';
part 'create_booking_state.dart';

class CreateBookingBloc extends Bloc<CreateBookingEvent, CreateBookingState> {
  CreateBookingBloc() : super(CreateBookingInitial()) {
    on<CreateBookingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
