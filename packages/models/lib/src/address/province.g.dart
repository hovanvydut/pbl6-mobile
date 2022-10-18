// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Province _$ProvinceFromJson(Map<String, dynamic> json) => Province(
      id: json['id'] as int,
      name: json['name'] as String,
      districts: (json['addressDistricts'] as List<dynamic>?)
              ?.map((e) => District.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <District>[],
    );

Map<String, dynamic> _$ProvinceToJson(Province instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'addressDistricts': instance.districts,
    };
