import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/src/property/property.dart';

part 'group_property.g.dart';

@JsonSerializable(createToJson: false)
class GroupProperty extends Equatable {
  const GroupProperty({
    required this.id,
    required this.displayName,
    required this.properties,
  });

  factory GroupProperty.fromJson(Map<String, dynamic> json) =>
      _$GroupPropertyFromJson(json);
  final int id;
  final String displayName;
  final List<Property> properties;

  @override
  List<Object> get props => [id, displayName, properties];
}
