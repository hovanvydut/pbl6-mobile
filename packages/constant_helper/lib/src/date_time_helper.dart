class DateTimeHelper {
  static DateTime get firstDateOfWeek {
    final now = DateTime.now();
    final firstDate = now.subtract(
      Duration(
        days: now.weekday - 1,
      ),
    );
    return DateTime(firstDate.year, firstDate.month, firstDate.day);
  }

  static DateTime get lastDateOfWeek {
    final now = DateTime.now();
    final lastDate = now.add(
      Duration(
        days: DateTime.daysPerWeek - now.weekday,
      ),
    );
    return DateTime(lastDate.year, lastDate.month, lastDate.day, 23, 59, 59);
  }

  static DateTime getDateInWeekByDOW(int dayOfWeek) {
    var dateInWeek = DateTime.now();
    for (var i = firstDateOfWeek.day; i <= lastDateOfWeek.day; i++) {
      dateInWeek = DateTime(firstDateOfWeek.year, firstDateOfWeek.month, i);
      if (dateInWeek.weekday == dayOfWeek) {
        break;
      }
    }
    return dateInWeek;
  }

  static Map<int, String> rruleWeekDay = {
    1: 'MO',
    2: 'TU',
    3: 'WE',
    4: 'TH',
    5: 'FR',
    6: 'SA',
    7: 'SU',
  };

  static String getRRuleWeekDay(int dayOfWeek) {
    return rruleWeekDay[dayOfWeek]!;
  }
}
