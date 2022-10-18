import 'package:json_annotation/json_annotation.dart';

part 'ward.g.dart';


@JsonSerializable()
class Ward {
  const Ward({required this.id, required this.name});

  factory Ward.fromJson(Map<String, dynamic> json) => _$WardFromJson(json);

  Map<String, dynamic> toJson() => _$WardToJson(this);

  final int id;
  final String name;
}
