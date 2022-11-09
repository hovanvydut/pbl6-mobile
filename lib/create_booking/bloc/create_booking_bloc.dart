import 'package:booking/booking.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/booking/booking.dart';

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

  Future<void> _onPageStarted(
    CreateBookingPageStarted event,
    Emitter<CreateBookingState> emit,
  ) async {
    try {
      emit(state.copyWith(pageLoadingStatus: LoadingStatus.loading));
      final freetimes = await _bookingRepository
          .getFreeTimeByUserId(state.post.authorInfo!.id);
      final appointments = <AppointmentInfo>[];

      for (final freetime in freetimes) {
        final dateFromFreetime =
            DateTimeHelper.getDateInWeekByDOW(freetime.day);
        final startTime =
            dateFromFreetime.add(Duration(hours: int.parse(freetime.start)));
        final endTime =
            dateFromFreetime.add(Duration(hours: int.parse(freetime.end)));
        final isBooking = appointments.any(
          (appointment) => appointment.start == startTime,
        );
        if (!isBooking) {
          appointments.add(
            AppointmentInfo(
              start: startTime,
              end: endTime,
              recurrenceRule: 'FREQ=WEEKLY;'
                  'BYDAY=${DateTimeHelper.getRRuleWeekDay(freetime.day)}',
            ),
          );
        }
      }
      emit(
        state.copyWith(
          pageLoadingStatus: LoadingStatus.done,
          freetimes: appointments,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(pageLoadingStatus: LoadingStatus.error));
      rethrow;
    }
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
        bookingTime: state.selectedTime.first.start,
      );
      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      addError(e);
      emit(state.copyWith(formzStatus: FormzStatus.submissionFailure));
      rethrow;
    }
  }
}
