import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/booking/booking.dart';
import 'package:pbl6_mobile/create_booking/create_booking.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CreateBookingCalendar extends StatelessWidget {
  const CreateBookingCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.5,
      child: BlocBuilder<CreateBookingBloc, CreateBookingState>(
        buildWhen: (previous, current) =>
            previous.freetimes != current.freetimes,
        builder: (context, state) {
          final freetimes = state.freetimes;
          return SfCalendar(
            view: CalendarView.week,
            dataSource: FreetimeCalendarSource(freetimes),
            timeSlotViewSettings: const TimeSlotViewSettings(
              timeIntervalHeight: 80,
              startHour: 6,
              endHour: 21,
              timeFormat: 'hh:mm a',
            ),
            onTap: (calendarTapDetails) {
              if (calendarTapDetails.date != null) {
                final selectedDate = calendarTapDetails.date!;
                if (selectedDate.isBefore(DateTime.now())) {
                  ToastHelper.showToast(
                    'Bạn không được chọn thời gian quá khứ',
                  );
                  return;
                }
                final appointmentInfo = AppointmentInfo(
                  start: selectedDate,
                  end: selectedDate.add(const Duration(hours: 1)),
                );
                context.read<CreateBookingBloc>().add(
                      SchedulePressed(appointmentInfo),
                    );
              }
            },
            firstDayOfWeek: 1,
          );
        },
      ),
    );
  }
}
