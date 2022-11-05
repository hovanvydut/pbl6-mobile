part of 'create_booking_bloc.dart';

abstract class CreateBookingEvent extends Equatable {
  const CreateBookingEvent();

  @override
  List<Object?> get props => [];
}

class StepPressed extends CreateBookingEvent {
  const StepPressed(this.index);
  final int index;

  @override
  List<Object?> get props => [index];
}

class BookingPhoneNumberChanged extends CreateBookingEvent {
  const BookingPhoneNumberChanged(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}
