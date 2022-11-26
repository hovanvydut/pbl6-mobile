import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_history.g.dart';

@JsonSerializable(createToJson: false)
class CreditHistory extends Equatable {
  const CreditHistory({
    required this.orderInfo,
    required this.amount,
    required this.bankCode,
    required this.transactionStatus,
    required this.userId,
    required this.userEmail,
    required this.createdAt,
  });
  factory CreditHistory.fromJson(Map<String, dynamic> json) =>
      _$CreditHistoryFromJson(json);

  final String orderInfo;
  final double amount;
  final String bankCode;
  final String transactionStatus;
  @JsonKey(name: 'userAccountId')
  final int userId;
  final String userEmail;
  @JsonKey(fromJson: _fromJson)
  final DateTime createdAt;

  static DateTime _fromJson(String date) =>
      DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date, true);

  bool get isSuccessful => transactionStatus == 'Giao dịch thành công';

  bool get isNotSuccessful => !isSuccessful;

  @override
  List<Object?> get props {
    return [
      orderInfo,
      amount,
      bankCode,
      transactionStatus,
      userId,
      userEmail,
      createdAt,
    ];
  }
}
