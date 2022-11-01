import 'package:intl/intl.dart';

extension CurrencyExtension on num? {
  /// ex: 15 tr VND
  String get inCompactCurrency {
    final format = NumberFormat.compactCurrency(locale: 'vi');
    return format.format(this);
  }

  /// ex: 15 tr
  String get inCompactCurrencyNotSymbol {
    final format = NumberFormat.compact(locale: 'vi');
    return format.format(this);
  }

  /// ex: 15 triệu VND
  String get inCompactLongCurrency {
    final format = NumberFormat.compactLong(locale: 'vi');
    return '${format.format(this)} VND';
  }

  /// ex: 15 triệu
  String get inCompactLongCurrencyNotSymbol {
    final format = NumberFormat.compactLong(locale: 'vi');
    return format.format(this);
  }

  /// ex: 15 tr đ
  String get inCompactSimpleCurrency {
    final format = NumberFormat.compactSimpleCurrency(locale: 'vi');
    return format.format(this);
  }

  /// ex: 15.000.000 đ
  String get inSimpleCurrency {
    final format = NumberFormat.simpleCurrency(locale: 'vi');
    return format.format(this);
  }
}
