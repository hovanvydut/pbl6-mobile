// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as int,
      postId: json['postId'] as int,
      userInfo: User.fromJson(json['userInfo'] as Map<String, dynamic>),
      content: json['content'] as String,
      rating: json['rating'] as int,
      medias: (json['medias'] as List<dynamic>)
          .map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
