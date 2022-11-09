part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class BookingPageStarted extends BookingEvent {}

class EditUpdatedFreetime extends BookingEvent {
  const EditUpdatedFreetime(this.freetimes);
  final List<AppointmentInfo> freetimes;

  @override
  List<Object?> get props => [freetimes];
}

class ApprovePressed extends BookingEvent {
  const ApprovePressed(this.bookingId);
  final int bookingId;

  @override
  List<Object?> get props => [bookingId];
}

class ConfirmMeetingPressed extends BookingEvent {
  const ConfirmMeetingPressed(this.bookingId);
  final int bookingId;

  @override
  List<Object?> get props => [bookingId];
}
