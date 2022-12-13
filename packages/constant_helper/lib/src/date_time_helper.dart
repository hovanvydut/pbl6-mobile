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
    final daysToGenerate = lastDateOfWeek.difference(firstDateOfWeek).inDays;
    final days = List.generate(
      daysToGenerate,
      (i) => DateTime(
        firstDateOfWeek.year,
        firstDateOfWeek.month,
        firstDateOfWeek.day + i,
      ),
    );
    final dateInWeek = days.firstWhere(
      (date) => date.weekday == dayOfWeek,
    );
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
