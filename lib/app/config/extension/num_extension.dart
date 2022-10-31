import 'package:intl/intl.dart';

extension CurrencyExtension on num? {
  String get inCompactCurrency {
    final format = NumberFormat.compactCurrency(locale: 'vi');
    return format.format(this);
  }

  String get inCompactLongCurrency {
    final format = NumberFormat.compactLong(locale: 'vi');
    return '${format.format(this)} VND';
  }

  String get inCompactSimpleCurrency {
    final format = NumberFormat.compactSimpleCurrency(locale: 'vi');
    return format.format(this);
  }

  String get inCompactCurrencyNotSymbol {
    final format = NumberFormat.compact(locale: 'vi');
    return format.format(this);
  }

  String get inSimpleCurrency {
    final format = NumberFormat.simpleCurrency(locale: 'vi');
    return format.format(this);
  }
}
