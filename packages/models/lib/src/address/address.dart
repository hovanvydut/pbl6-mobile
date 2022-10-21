// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'address.g.dart';

@JsonSerializable(createToJson: false)
class Address extends Equatable {
  const Address({
    required this.province,
    required this.district,
    required this.ward,
  });
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  final Province province;
  final District district;
  final Ward ward;

  @override
  List<Object?> get props => [province, district, ward];

  @override
  String toString() {
    return '${ward.name}, ${district.name}, ${province.name}';
  }
}
