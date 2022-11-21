// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uptop_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UptopData _$UptopDataFromJson(Map<String, dynamic> json) => UptopData(
      uptopId: json['uptopId'] as int,
      title: json['title'] as String,
      slug: json['slug'] as String,
      address: json['address'] as String,
      startTime: UptopData._fromJson(json['startTime'] as String),
      endTime: UptopData._fromJson(json['endTime'] as String),
    );
