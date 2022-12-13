import 'package:json_annotation/json_annotation.dart';

enum NotificationType {
  @JsonValue('REVIEW__HAS_REVIEW_ON_POST')
  hasReviewOnPost,

  @JsonValue('BOOKING__HAS_BOOKING_ON_POST')
  hasBookingOnPost,

  @JsonValue('BOOKING__HOST_CONFIRM_MET')
  hostConfirmMet,

  @JsonValue('BOOKING__HOST_APPROVE_MEETING')
  hostApproveMeeting,
}
