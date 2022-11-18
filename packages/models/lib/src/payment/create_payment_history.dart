import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_payment_history.g.dart';

@JsonSerializable()
class CreatePaymentHistory extends Equatable {
  const CreatePaymentHistory({
    required this.orderInfo,
    required this.amount,
    required this.bankCode,
    required this.transactionStatus,
    required this.userId,
    required this.userEmail,
    required this.createdAt,
  });
  factory CreatePaymentHistory.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentHistoryFromJson(json);

  final String orderInfo;
  final int amount;
  final String bankCode;
  final String transactionStatus;
  @JsonKey(name: 'userAccountId')
  final int userId;
  final String userEmail;
  @JsonKey(fromJson: _fromJson)
  final DateTime createdAt;

  static DateTime _fromJson(String date) =>
      DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date, true);

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
