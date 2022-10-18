// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

District _$DistrictFromJson(Map<String, dynamic> json) => District(
      id: json['id'] as int,
      name: json['name'] as String,
      wards: (json['addressDistricts'] as List<dynamic>?)
              ?.map((e) => Ward.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Ward>[],
    );

Map<String, dynamic> _$DistrictToJson(District instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'addressDistricts': instance.wards,
    };
