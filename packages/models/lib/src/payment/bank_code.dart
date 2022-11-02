import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bank_code.g.dart';

@JsonSerializable(createToJson: false)
class BankCode extends Equatable {
  const BankCode({
    required this.id,
    required this.code,
    required this.description,
  });

  factory BankCode.fromJson(Map<String, dynamic> json) =>
      _$BankCodeFromJson(json);

  final int id;
  final String code;
  final String description;

  @override
  List<Object> get props => [id, code, description];
}
