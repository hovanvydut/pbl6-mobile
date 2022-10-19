import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ward.g.dart';

@JsonSerializable(createToJson: false)
class Ward extends Equatable {
  const Ward({required this.id, required this.name});

  factory Ward.fromJson(Map<String, dynamic> json) => _$WardFromJson(json);

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
