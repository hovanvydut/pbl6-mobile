// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const [
      'id',
      'originUserId',
      'originUserEmail',
      'originUserName',
      'originUserAvatar',
      'code',
      'hasRead',
      'extraData',
      'createdAt'
    ],
  );
  return NotificationData(
    id: json['id'] as int,
    userId: json['originUserId'] as int,
    userEmail: json['originUserEmail'] as String,
    username: json['originUserName'] as String,
    avatarUrl: json['originUserAvatar'] as String,
    code: $enumDecode(_$NotificationTypeEnumMap, json['code']),
    hasRead: json['hasRead'] as bool,
    extraData: NotificationData._extraDataFromJson(json['extraData'] as String),
    createdAt: NotificationData._dateTimeFromJson(json['createdAt'] as String),
  );
}

const _$NotificationTypeEnumMap = {
  NotificationType.hasReviewOnPost: 'REVIEW__HAS_REVIEW_ON_POST',
  NotificationType.hasBookingOnPost: 'BOOKING__HAS_BOOKING_ON_POST',
  NotificationType.hostConfirmMet: 'BOOKING__HOST_CONFIRM_MET',
  NotificationType.hostApproveMeeting: 'BOOKING__HOST_APPROVE_MEETING',
};
