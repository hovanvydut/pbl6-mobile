import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'uptop_data.g.dart';

@JsonSerializable(createToJson: false)
class UptopData extends Equatable {
  const UptopData({
    required this.uptopId,
    required this.title,
    this.slug,
    required this.address,
    required this.startTime,
    required this.endTime,
  });

  factory UptopData.fromJson(Map<String, dynamic> json) =>
      _$UptopDataFromJson(json);

  @JsonKey(name: 'id')
  final int uptopId;
  final String title;
  final String? slug;
  final String address;
  @JsonKey(fromJson: _fromJson)
  final DateTime startTime;
  @JsonKey(fromJson: _fromJson)
  final DateTime endTime;

  static DateTime _fromJson(String date) =>
      DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date, true);

  @override
  List<Object?> get props {
    return [
      uptopId,
      title,
      slug,
      address,
      startTime,
      endTime,
    ];
  }
}
