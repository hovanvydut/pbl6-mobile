import 'package:equatable/equatable.dart';
import 'package:models/models.dart';

class AppointmentInfo extends Equatable {
  const AppointmentInfo({
    required this.start,
    required this.end,
    this.bookingData,
  });
  final DateTime start;
  final DateTime end;
  final BookingData? bookingData;

  @override
  List<Object?> get props => [start, end, bookingData];

  AppointmentInfo copyWith({
    DateTime? start,
    DateTime? end,
    BookingData? bookingData,
  }) {
    return AppointmentInfo(
      start: start ?? this.start,
      end: end ?? this.end,
      bookingData: bookingData ?? this.bookingData,
    );
  }
}
