import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'debit_history.g.dart';

@JsonSerializable()
class DebitHistory extends Equatable {
  const DebitHistory({
    required this.paymentCode,
    required this.hostId,
    required this.hostEmail,
    required this.postId,
    required this.paymentType,
    required this.amount,
    required this.description,
    required this.createdAt,
  });

  factory DebitHistory.fromJson(Map<String, dynamic> json) =>
      _$DebitHistoryFromJson(json);

  final String paymentCode;
  final int hostId;
  final String hostEmail;
  final int postId;
  final String paymentType;
  final int amount;
  final String description;
  @JsonKey(fromJson: _fromJson)
  final DateTime createdAt;

  static DateTime _fromJson(String date) =>
      DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date, true);

  @override
  List<Object?> get props {
    return [
      paymentCode,
      hostId,
      hostEmail,
      postId,
      paymentType,
      amount,
      description,
      createdAt,
    ];
  }
}
