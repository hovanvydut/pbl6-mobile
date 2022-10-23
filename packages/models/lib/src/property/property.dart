import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'property.g.dart';

@JsonSerializable(createToJson: false)
class Property extends Equatable {
  const Property({
    required this.id,
    required this.displayName,
    required this.groupPropertyId,
  });

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  final int id;
  final String displayName;
  @JsonKey(name: 'propertyGroupId')
  final int groupPropertyId;

  @override
  List<Object> get props => [id, displayName];
}
