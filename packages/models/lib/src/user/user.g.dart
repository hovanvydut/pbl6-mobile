// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      displayName: json['displayName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      role: $enumDecodeNullable(_$RoleEnumMap, json['role']),
      identityNumber: json['identityNumber'] as String?,
      currentCredit: json['currentCredit'] as int?,
      avatar: json['avatar'] as String?,
      address: json['address'] as String,
      addressWardId: json['addressWardId'] as int,
      addressWard: json['addressWard'] as String?,
      addressDistrict: json['addressDistrict'] as String?,
      addressProvince: json['addressProvince'] as String?,
      userAccountId: json['userAccountId'] as int?,
      userAccountEmail: json['userAccountEmail'] as String?,
    );

const _$RoleEnumMap = {
  Role.admin: 1,
  Role.host: 2,
  Role.guest: 3,
  Role.hostAndGuest: 4,
};
