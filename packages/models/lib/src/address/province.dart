import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'province.g.dart';

@JsonSerializable()
class Province {
  Province({
    required this.id,
    required this.name,
    this.districts = const <District>[],
  });

  factory Province.fromJson(Map<String, dynamic> json) =>
      _$ProvinceFromJson(json);

  final int id;
  final String name;
  @JsonKey(name: 'addressDistricts')
  final List<District> districts;

  Map<String, dynamic> toJson() => _$ProvinceToJson(this);
}
