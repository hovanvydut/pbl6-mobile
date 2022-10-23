import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'province.g.dart';

@JsonSerializable(createToJson: false)
class Province extends Equatable {
  const Province({
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

  @override
  List<Object?> get props => [id, name, districts];
}
