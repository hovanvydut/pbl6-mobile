// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditHistory _$CreditHistoryFromJson(Map<String, dynamic> json) =>
    CreditHistory(
      orderInfo: json['orderInfo'] as String,
      amount: (json['amount'] as num).toDouble(),
      bankCode: json['bankCode'] as String,
      transactionStatus: json['transactionStatus'] as String,
      userId: json['userAccountId'] as int,
      userEmail: json['userEmail'] as String,
      createdAt: CreditHistory._fromJson(json['createdAt'] as String),
    );
