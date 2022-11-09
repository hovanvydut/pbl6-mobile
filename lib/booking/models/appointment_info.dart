import 'package:equatable/equatable.dart';
import 'package:models/models.dart';

class AppointmentInfo extends Equatable {
  const AppointmentInfo({
    required this.start,
    required this.end,
    this.bookingData,
    this.recurrenceRule,
  });
  final DateTime start;
  final DateTime end;
  final BookingData? bookingData;
  final String? recurrenceRule;

  @override
  List<Object?> get props => [
        start,
        end,
        bookingData,
        recurrenceRule,
      ];

  AppointmentInfo copyWith({
    DateTime? start,
    DateTime? end,
    BookingData? bookingData,
    String? recurrenceRule,
  }) {
    return AppointmentInfo(
      start: start ?? this.start,
      end: end ?? this.end,
      bookingData: bookingData ?? this.bookingData,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
    );
  }
}
