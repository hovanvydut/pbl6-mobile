import 'package:pbl6_mobile/booking/booking.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class FreetimeCalendarSource extends CalendarDataSource<AppointmentInfo> {
  FreetimeCalendarSource(List<AppointmentInfo> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return (appointments as List<AppointmentInfo>?)![index].start;
  }

  @override
  DateTime getEndTime(int index) {
    return (appointments as List<AppointmentInfo>?)![index].end;
  }

  @override
  String? getRecurrenceRule(int index) {
    return (appointments as List<AppointmentInfo>?)![index].recurrenceRule;
  }

  @override
  AppointmentInfo? convertAppointmentToObject(
    AppointmentInfo? customData,
    Appointment appointment,
  ) {
    return AppointmentInfo(
      start: appointment.startTime,
      end: appointment.endTime,
    );
  }
}
