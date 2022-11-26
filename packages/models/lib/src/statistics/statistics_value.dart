import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'statistics_value.g.dart';

@JsonSerializable(createToJson: false)
class StatisticsValue extends Equatable {
  @JsonKey(name: 'statisticValue')
  final int value;
  @JsonKey(name: 'statisticDate')
  final String date;
  const StatisticsValue({
    required this.value,
    required this.date,
  });

  factory StatisticsValue.fromJson(Map<String, dynamic> json) =>
      _$StatisticsValueFromJson(json);

  @override
  List<Object?> get props => [value, date];
}
