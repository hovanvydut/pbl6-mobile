// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnreadData _$UnreadDataFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['allTime', 'today'],
  );
  return UnreadData(
    allTime: json['allTime'] as int,
    today: json['today'] as int,
  );
}
