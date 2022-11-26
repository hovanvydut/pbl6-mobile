import 'dart:async';

import 'package:booking/booking.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/booking/booking.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc({
    required User user,
    required BookingRepository bookingRepository,
  })  : _bookingRepository = bookingRepository,
        super(BookingState(user: user)) {
    on<BookingPageStarted>(_onBookingPageStarted);
    on<ApprovePressed>(_onApprove);
    on<ConfirmMeetingPressed>(_onConfirmMeeting);
    on<EditUpdatedFreetime>(_onEditUpdatedFreetime);

    add(BookingPageStarted());
  }

  final BookingRepository _bookingRepository;

  Future<void> _onBookingPageStarted(
    BookingPageStarted event,
    Emitter<BookingState> emit,
  ) async {
    try {
      emit(state.copyWith(pageLoadingStatus: LoadingStatus.loading));
      final bookingDatas = await _bookingRepository.getBookingList();
      final freetimes =
          await _bookingRepository.getFreeTimeByUserId(state.user.id);
      final appointments = <AppointmentInfo>[];

      for (final bookingData in bookingDatas) {
        appointments.add(
          AppointmentInfo(
            bookingData: bookingData,
            start: bookingData.time.toLocal(),
            end: bookingData.time.toLocal().add(const Duration(hours: 1)),
          ),
        );
      }

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
          appointments: appointments,
          freetimes: appointments
              .where((appointment) => appointment.bookingData == null)
              .toList(),
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(pageLoadingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onApprove(
    ApprovePressed event,
    Emitter<BookingState> emit,
  ) async {
    try {
      emit(state.copyWith(approveStatus: LoadingStatus.loading));
      await _bookingRepository.approveBooking(bookingId: event.bookingId);
      final appoinment = state.appointments.firstWhere(
        (appointment) => appointment.bookingData!.id == event.bookingId,
      );
      state.appointments.remove(appoinment);
      state.appointments.add(
        appoinment.copyWith(
          bookingData:
              appoinment.bookingData!.copyWith(approveTime: DateTime.now()),
        ),
      );
      emit(
        state.copyWith(
          approveStatus: LoadingStatus.done,
          appointments: List.from(state.appointments),
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(approveStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onConfirmMeeting(
    ConfirmMeetingPressed event,
    Emitter<BookingState> emit,
  ) async {
    try {
      emit(state.copyWith(confirmMeetingStatus: LoadingStatus.loading));
      await _bookingRepository.confirmMeeting(bookingId: event.bookingId);
      final appoinment = state.appointments.firstWhere(
        (appointment) =>
            appointment.bookingData != null &&
            appointment.bookingData!.id == event.bookingId,
      );
      state.appointments.remove(appoinment);
      state.appointments.add(
        appoinment.copyWith(
          bookingData: appoinment.bookingData!.copyWith(isMeet: true),
        ),
      );
      emit(
        state.copyWith(
          confirmMeetingStatus: LoadingStatus.done,
          appointments: List.from(state.appointments),
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(confirmMeetingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  void _onEditUpdatedFreetime(
    EditUpdatedFreetime event,
    Emitter<BookingState> emit,
  ) {
    final currentAppointments = state.appointments
      ..removeWhere((appointment) => appointment.bookingData == null);
    for (final freetime in event.freetimes) {
      final isBooking = currentAppointments.any(
        (appointment) => appointment.start == freetime.start,
      );
      if (!isBooking) {
        currentAppointments.add(
          AppointmentInfo(
            start: freetime.start,
            end: freetime.end,
          ),
        );
      }
    }
    emit(
      state.copyWith(
        appointments: List.from(currentAppointments),
        freetimes: event.freetimes,
      ),
    );
  }
}
