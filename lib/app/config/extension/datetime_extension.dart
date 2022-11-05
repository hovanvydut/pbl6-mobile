import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExtension on DateTime {
  String get yMd {
    final dateFormatter = DateFormat.yMd('vi');
    return dateFormatter.format(this);
  }

  String get toTimeAgo => timeago.format(this, locale: 'vi');
}
