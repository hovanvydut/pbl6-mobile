import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unread_data.g.dart';

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class UnreadData extends Equatable {
  const UnreadData({
    required this.allTime,
    required this.today,
  });
  factory UnreadData.fromJson(Map<String, dynamic> json) =>
      _$UnreadDataFromJson(json);

  final int allTime;
  final int today;

  @override
  List<Object> get props => [allTime, today];
}
