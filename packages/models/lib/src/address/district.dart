import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'district.g.dart';

@JsonSerializable()
class District {
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

  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
