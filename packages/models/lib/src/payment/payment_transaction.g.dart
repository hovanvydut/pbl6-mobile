// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTransaction _$PaymentTransactionFromJson(Map<String, dynamic> json) =>
    PaymentTransaction(
      paymentCode: json['paymentCode'] as String,
      hostId: json['hostId'] as int,
      hostEmail: json['hostEmail'] as String,
      postId: json['postId'] as int,
      paymentType: json['paymentType'] as String,
      amount: json['amount'] as int,
      description: json['description'] as String,
      createdAt: PaymentTransaction._fromJson(json['createdAt'] as String),
    );

Map<String, dynamic> _$PaymentTransactionToJson(PaymentTransaction instance) =>
    <String, dynamic>{
      'paymentCode': instance.paymentCode,
      'hostId': instance.hostId,
      'hostEmail': instance.hostEmail,
      'postId': instance.postId,
      'paymentType': instance.paymentType,
      'amount': instance.amount,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };
