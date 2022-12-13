// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraData _$ExtraDataFromJson(Map<String, dynamic> json) => ExtraData(
      postId: json['PostId'] as int,
      postTitle: json['PostTitle'] as String,
      bookingId: json['BookingId'] as int?,
      reviewId: json['ReviewId'] as int?,
      reviewContent: json['ReviewContent'] as String?,
      reviewRating: json['ReviewRating'] as int?,
      bookingTime: ExtraData._fromJson(json['BookingTime'] as String?),
    );

Map<String, dynamic> _$ExtraDataToJson(ExtraData instance) => <String, dynamic>{
      'PostId': instance.postId,
      'PostTitle': instance.postTitle,
      'BookingId': instance.bookingId,
      'ReviewId': instance.reviewId,
      'ReviewContent': instance.reviewContent,
      'ReviewRating': instance.reviewRating,
      'BookingTime': instance.bookingTime?.toIso8601String(),
    };
