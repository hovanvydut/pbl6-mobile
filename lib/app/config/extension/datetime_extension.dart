import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExtension on DateTime {
  String get yMd {
    final dateFormatter = DateFormat.yMd('vi');
    return dateFormatter.format(this);
  }

  String get yMdHm {
    final dateFormatter = DateFormat.yMd('vi');
    final timeFormatter = DateFormat.Hm('vi');

    return '${dateFormatter.format(this)} ${timeFormatter.format(this)}';
  }

  String get timeAgo => timeago.format(this, locale: 'vi');

  int get dayOfWeek => weekday + 1;

  // ignore: non_constant_identifier_names
  String get Hm {
    final timeFormatter = DateFormat.Hm('vi');
    return timeFormatter.format(this);
  }
}
