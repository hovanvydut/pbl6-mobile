import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'house_type.g.dart';

@JsonSerializable(createToJson: false)
class HouseType extends Equatable {
  const HouseType({required this.id, required this.name, required this.slug});
  factory HouseType.fromJson(Map<String, dynamic> json) =>
      _$HouseTypeFromJson(json);

  final int id;
  final String name;
  final String slug;

  @override
  List<Object?> get props => [id, name, slug];
}
