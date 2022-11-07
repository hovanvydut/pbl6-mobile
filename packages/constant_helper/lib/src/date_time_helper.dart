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
}
