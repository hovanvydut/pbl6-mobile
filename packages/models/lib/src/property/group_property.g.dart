// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupProperty _$GroupPropertyFromJson(Map<String, dynamic> json) =>
    GroupProperty(
      id: json['id'] as int,
      displayName: json['displayName'] as String,
      properties: (json['properties'] as List<dynamic>)
          .map((e) => Property.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
