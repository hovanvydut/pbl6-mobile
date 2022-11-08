// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      area: (json['area'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      prePaidPrice: (json['prePaidPrice'] as num?)?.toDouble(),
      slug: json['slug'] as String?,
      limitTenant: json['limitTenant'] as int?,
      numView: json['numView'] as int?,
      address: json['address'] as String,
      fullAddress:
          Address.fromJson(json['fullAddress'] as Map<String, dynamic>),
      category: HouseType.fromJson(json['category'] as Map<String, dynamic>),
      properties: (json['properties'] as List<dynamic>?)
          ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
          .toList(),
      groupProperties: (json['propertyGroup'] as List<dynamic>?)
          ?.map((e) => GroupProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
      medias: (json['medias'] as List<dynamic>)
          .map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      authorInfo: json['authorInfo'] == null
          ? null
          : User.fromJson(json['authorInfo'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );
