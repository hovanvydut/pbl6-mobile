// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingData _$BookingDataFromJson(Map<String, dynamic> json) => BookingData(
      id: json['id'] as int,
      guestInfo: GuestInfo.fromJson(json['guestInfo'] as Map<String, dynamic>),
      time: DateTime.parse(json['time'] as String),
      approveTime: json['approveTime'] == null
          ? null
          : DateTime.parse(json['approveTime'] as String),
      isMeet: json['met'] as bool,
    );
