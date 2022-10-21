import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'district.g.dart';

@JsonSerializable(createToJson: false)
class District extends Equatable {
  const District({
    required this.id,
    required this.name,
    this.wards = const <Ward>[],
  });

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  final int id;
  final String name;
  @JsonKey(name: 'addressDistricts')
  final List<Ward> wards;

  @override
  List<Object?> get props => [id, name, wards];
}
