import 'package:booking/booking.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';

part 'create_booking_event.dart';
part 'create_booking_state.dart';

class CreateBookingBloc extends Bloc<CreateBookingEvent, CreateBookingState> {
  CreateBookingBloc({
    required Post post,
    required BookingRepository bookingRepository,
  })  : _bookingRepository = bookingRepository,
        super(CreateBookingState(post: post)) {
    on<CreateBookingPageStarted>(_onPageStarted);
    on<StepPressed>(_onStepPressed);
    on<BookingPhoneNumberChanged>(_onBookingPhoneNumberChanged);
    on<SchedulePressed>(_onSchedulePressed);
    on<RemoveSchedulePressed>(_onRemoveSchedulePressed);
    on<ConfirmSchedulePressed>(_onConfirmSchedulePressed);
    on<CreateBookingSubmitted>(_onSubmitted);
    add(CreateBookingPageStarted());
  }

  final BookingRepository _bookingRepository;

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

  void _onPageStarted(
    CreateBookingPageStarted event,
    Emitter<CreateBookingState> emit,
  ) {
    emit(
      state.copyWith(
        freetimes: List.from([
          Freetime(
            day: 0,
            start: DateTime.now()
                .subtract(const Duration(hours: 2))
                .toIso8601String(),
            end: DateTime.now()
                .subtract(const Duration(hours: 1))
                .toIso8601String(),
          ),
          Freetime(
            day: 1,
            start:
                DateTime.now().add(const Duration(days: 1)).toIso8601String(),
            end: DateTime.now()
                .add(const Duration(days: 1))
                .add(const Duration(hours: 2))
                .toIso8601String(),
          )
        ]),
      ),
    );
  }

  void _onSchedulePressed(
    SchedulePressed event,
    Emitter<CreateBookingState> emit,
  ) {
    emit(state.copyWith(tempSelectedTime: List.from([event.time])));
  }

  void _onRemoveSchedulePressed(
    RemoveSchedulePressed event,
    Emitter<CreateBookingState> emit,
  ) {
    emit(state.copyWith(tempSelectedTime: List.from([])));
  }

  void _onConfirmSchedulePressed(
    ConfirmSchedulePressed event,
    Emitter<CreateBookingState> emit,
  ) {
    emit(state.copyWith(selectedTime: state.tempSelectedTime));
  }

  Future<void> _onSubmitted(
    CreateBookingSubmitted event,
    Emitter<CreateBookingState> emit,
  ) async {
    try {
      emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
      await _bookingRepository.createBooking(
        postId: state.post.id,
        bookingTime: state.selectedTime.first.start.toDateTime,
      );
      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      addError(e);
      emit(state.copyWith(formzStatus: FormzStatus.submissionFailure));
      rethrow;
    }
  }
}
