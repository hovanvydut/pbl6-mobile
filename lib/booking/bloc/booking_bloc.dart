import 'dart:async';

import 'package:booking/booking.dart';
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
      // final test = BookingData(
      //   id: 131,
      //   isMeet: false,
      //   time: '2022-11-08T10:00:00.000'.toDateTime,
      //   guestInfo: const GuestInfo(
      //     id: 1,
      //     displayName: 'Phuong Tran',
      //     avatar:
      //         'https://pbl6.s3.ap-southeast-1.amazonaws.com/312554885_1848921128805193_3095384672118521778_n.jpg',
      //     phoneNumber: '0336615425',
      //   ),
      // );
      for (final bookingData in bookingDatas) {
        appointments.add(
          AppointmentInfo(
            bookingData: bookingData,
            start: bookingData.time.toUtc(),
            end: bookingData.time.add(const Duration(hours: 1)),
          ),
        );
      }
      // appointments.add(
      //   AppointmentInfo(
      //     bookingData: test,
      //     start: test.time,
      //     end: test.time.add(const Duration(hours: 1)),
      //   ),
      // );
      for (final freetime in freetimes) {
        final isBooking = appointments.any(
          (appointment) => appointment.start == freetime.start.toDateTime,
        );
        if (!isBooking) {
          appointments.add(
            AppointmentInfo(
              start: freetime.start.toDateTime,
              end: freetime.end.toDateTime,
            ),
          );
        }
      }
      emit(
        state.copyWith(
          pageLoadingStatus: LoadingStatus.done,
          appointments: appointments,
          freetimes: freetimes,
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
        (appointment) => appointment.bookingData!.id == event.bookingId,
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
        (appointment) => appointment.start == freetime.start.toDateTime,
      );
      if (!isBooking) {
        currentAppointments.add(
          AppointmentInfo(
            start: freetime.start.toDateTime,
            end: freetime.end.toDateTime,
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
