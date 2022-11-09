part of 'booking_bloc.dart';

class BookingState extends Equatable {
  const BookingState({
    required this.user,
    this.appointments = const [],
    this.freetimes = const [],
    this.pageLoadingStatus = LoadingStatus.initial,
    this.approveStatus = LoadingStatus.initial,
    this.confirmMeetingStatus = LoadingStatus.initial,
  });

  final User user;

  final List<AppointmentInfo> appointments;

  final List<AppointmentInfo> freetimes;

  final LoadingStatus pageLoadingStatus;

  final LoadingStatus approveStatus;

  final LoadingStatus confirmMeetingStatus;

  @override
  List<Object> get props {
    return [
      user,
      appointments,
      freetimes,
      pageLoadingStatus,
      approveStatus,
      confirmMeetingStatus,
    ];
  }

  BookingState copyWith({
    User? user,
    List<AppointmentInfo>? appointments,
    List<AppointmentInfo>? freetimes,
    LoadingStatus? pageLoadingStatus,
    LoadingStatus? approveStatus,
    LoadingStatus? confirmMeetingStatus,
  }) {
    return BookingState(
      user: user ?? this.user,
      appointments: appointments ?? this.appointments,
      freetimes: freetimes ?? this.freetimes,
      pageLoadingStatus: pageLoadingStatus ?? this.pageLoadingStatus,
      approveStatus: approveStatus ?? this.approveStatus,
      confirmMeetingStatus: confirmMeetingStatus ?? this.confirmMeetingStatus,
    );
  }
}
