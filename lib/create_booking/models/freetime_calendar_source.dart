import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class FreetimeCalendarSource extends CalendarDataSource {
  FreetimeCalendarSource(List<Freetime> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return (appointments as List<Freetime>?)![index].start.toDateTime;
  }

  @override
  DateTime getEndTime(int index) {
    return (appointments as List<Freetime>?)![index].end.toDateTime;
  }


}
