part of 'uptop_bloc.dart';

abstract class UptopEvent extends Equatable {
  const UptopEvent();

  @override
  List<Object?> get props => [];
}

class CreateDialogStarted extends UptopEvent {}

class DetailDialogStarted extends UptopEvent {}

class NumOfDayChanged extends UptopEvent {
  const NumOfDayChanged(this.day);
  final int day;

  @override
  List<Object?> get props => [day];
}

class StartDateChanged extends UptopEvent {
  const StartDateChanged(this.startDate);
  final DateTime startDate;

  @override
  List<Object?> get props => [startDate];
}

class UptopSubmitted extends UptopEvent {}
