// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      province: Province.fromJson(json['province'] as Map<String, dynamic>),
      district: District.fromJson(json['district'] as Map<String, dynamic>),
      ward: Ward.fromJson(json['ward'] as Map<String, dynamic>),
    );
