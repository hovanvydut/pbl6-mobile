import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'statistics_data.g.dart';

@JsonSerializable(createToJson: false)
class StatisticsData extends Equatable {
  const StatisticsData({
    required this.id,
    required this.title,
    this.slug,
    required this.isDeleted,
    required this.statisticValue,
  });

  factory StatisticsData.fromJson(Map<String, dynamic> json) =>
      _$StatisticsDataFromJson(json);

  final int id;
  final String title;
  final String? slug;
  final bool isDeleted;
  final int statisticValue;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      slug,
      isDeleted,
      statisticValue,
    ];
  }
}
