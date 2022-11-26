import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config_data.g.dart';

@JsonSerializable(createToJson: false)
class ConfigData extends Equatable {
  const ConfigData({
    required this.key,
    required this.description,
    required this.value,
  });
  factory ConfigData.fromJson(Map<String, dynamic> json) =>
      _$ConfigDataFromJson(json);
  final String key;
  final String description;
  final int value;

  @override
  List<Object> get props => [key, description, value];
}
