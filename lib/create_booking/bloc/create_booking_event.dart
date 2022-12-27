part of 'create_booking_bloc.dart';

abstract class CreateBookingEvent extends Equatable {
  const CreateBookingEvent();

  @override
  List<Object?> get props => [];
}

class CreateBookingPageStarted extends CreateBookingEvent {}

class StepPressed extends CreateBookingEvent {
  const StepPressed(this.index);
  final int index;

  @override
  List<Object?> get props => [index];
}

class SchedulePressed extends CreateBookingEvent {
  const SchedulePressed(this.time);
  final AppointmentInfo time;

  @override
  List<Object?> get props => [time];
}

class RemoveSchedulePressed extends CreateBookingEvent {}

class ConfirmSchedulePressed extends CreateBookingEvent {}

class CreateBookingSubmitted extends CreateBookingEvent {}
