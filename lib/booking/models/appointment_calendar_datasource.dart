import 'package:flutter/material.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/booking/booking.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as calendar;

class AppointmentCalendarDatasource extends calendar.CalendarDataSource {
  AppointmentCalendarDatasource(
    List<AppointmentInfo> appointments, {
    required this.context,
  }) {
    this.appointments = appointments;
  }

  final BuildContext context;

  @override
  DateTime getStartTime(int index) {
    return (appointments as List<AppointmentInfo>?)![index].start;
  }

  @override
  DateTime getEndTime(int index) {
    return (appointments as List<AppointmentInfo>?)![index].end;
  }

  @override
  String getSubject(int index) {
    return (appointments as List<AppointmentInfo>?)![index]
            .bookingData
            ?.guestInfo
            .displayName ??
        'Lịch rảnh của bạn';
  }

  @override
  Color getColor(int index) {
    final appointment = (appointments as List<AppointmentInfo>?)![index];
    if (appointment.bookingData != null) {
      if (appointment.bookingData!.approveTime != null) {
        if (appointment.bookingData!.isMeet) {
          return Colors.blue;
        }
        return Colors.green;
      } else {
        return context.theme.colorScheme.error;
      }
    }
    return context.theme.colorScheme.inverseSurface.withOpacity(0.3);
  }
}
