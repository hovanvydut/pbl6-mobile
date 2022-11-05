import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:models/models.dart';

part 'create_booking_event.dart';
part 'create_booking_state.dart';

class CreateBookingBloc extends Bloc<CreateBookingEvent, CreateBookingState> {
  CreateBookingBloc({
    required Post post,
  }) : super(CreateBookingState(post: post)) {
    on<StepPressed>(_onStepPressed);
    on<BookingPhoneNumberChanged>(_onBookingPhoneNumberChanged);
  }

  void _onStepPressed(StepPressed event, Emitter<CreateBookingState> emit) {
    emit(state.copyWith(currentStep: event.index));
  }

  void _onBookingPhoneNumberChanged(
    BookingPhoneNumberChanged event,
    Emitter<CreateBookingState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        formzStatus: Formz.validate([
          phoneNumber,
        ]),
      ),
    );
  }
}
