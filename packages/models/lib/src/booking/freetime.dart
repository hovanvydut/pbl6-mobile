import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'freetime.g.dart';

@JsonSerializable()
class Freetime extends Equatable {
  const Freetime({
    required this.day,
    required this.start,
    required this.end,
  });
  factory Freetime.fromJson(Map<String, dynamic> json) =>
      _$FreetimeFromJson(json);

  final int day;
  final String start;
  final String end;

  Map<String, dynamic> toJson() => _$FreetimeToJson(this);

  @override
  List<Object?> get props => [day, start, end];
}
