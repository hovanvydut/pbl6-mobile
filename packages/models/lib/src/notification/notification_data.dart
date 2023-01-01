import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/src/notification/extra_data.dart';
import 'package:models/src/notification/notification_type.dart';

part 'notification_data.g.dart';

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class NotificationData extends Equatable {
  const NotificationData({
    required this.id,
    required this.userId,
    required this.userEmail,
    required this.username,
    required this.avatarUrl,
    required this.code,
    required this.hasRead,
    required this.extraData,
    required this.createdAt,
  });
  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  final int id;
  @JsonKey(name: 'originUserId')
  final int userId;
  @JsonKey(name: 'originUserEmail')
  final String userEmail;
  @JsonKey(name: 'originUserName')
  final String username;
  @JsonKey(name: 'originUserAvatar')
  final String? avatarUrl;

  final NotificationType code;

  final bool hasRead;

  @JsonKey(fromJson: _extraDataFromJson)
  final ExtraData extraData;

  static ExtraData _extraDataFromJson(String data) =>
      ExtraData.fromJson(jsonDecode(data) as Map<String, dynamic>);

  @JsonKey(fromJson: _dateTimeFromJson)
  final DateTime createdAt;

  static DateTime _dateTimeFromJson(String value) =>
      DateFormat('yyyy-MM-ddTHH:mm:ss').parse(value, true);

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      userEmail,
      username,
      avatarUrl,
      code,
      hasRead,
      extraData,
      createdAt,
    ];
  }

  NotificationData copyWith({
    int? id,
    int? userId,
    String? userEmail,
    String? username,
    String? avatarUrl,
    NotificationType? code,
    bool? hasRead,
    ExtraData? extraData,
    DateTime? createdAt,
  }) {
    return NotificationData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      code: code ?? this.code,
      hasRead: hasRead ?? this.hasRead,
      extraData: extraData ?? this.extraData,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
