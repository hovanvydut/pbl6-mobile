// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_payment_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePaymentHistory _$CreatePaymentHistoryFromJson(
        Map<String, dynamic> json) =>
    CreatePaymentHistory(
      orderInfo: json['orderInfo'] as String,
      amount: json['amount'] as int,
      bankCode: json['bankCode'] as String,
      transactionStatus: json['transactionStatus'] as String,
      userId: json['userAccountId'] as int,
      userEmail: json['userEmail'] as String,
      createdAt: CreatePaymentHistory._fromJson(json['createdAt'] as String),
    );

Map<String, dynamic> _$CreatePaymentHistoryToJson(
        CreatePaymentHistory instance) =>
    <String, dynamic>{
      'orderInfo': instance.orderInfo,
      'amount': instance.amount,
      'bankCode': instance.bankCode,
      'transactionStatus': instance.transactionStatus,
      'userAccountId': instance.userId,
      'userEmail': instance.userEmail,
      'createdAt': instance.createdAt.toIso8601String(),
    };
