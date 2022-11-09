import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'booking_data.g.dart';

@JsonSerializable(createToJson: false)
class BookingData extends Equatable {
  const BookingData({
    required this.id,
    required this.guestInfo,
    required this.time,
    this.approveTime,
    required this.isMeet,
  });
  factory BookingData.fromJson(Map<String, dynamic> json) =>
      _$BookingDataFromJson(json);

  final int id;
  final GuestInfo guestInfo;
  @JsonKey(fromJson: _fromJson)
  final DateTime time;
  final DateTime? approveTime;
  @JsonKey(name: 'met')
  final bool isMeet;

  static DateTime _fromJson(String date) =>
      DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date, true);

  @override
  List<Object?> get props {
    return [
      id,
      guestInfo,
      time,
      approveTime,
      isMeet,
    ];
  }

  BookingData copyWith({
    int? id,
    GuestInfo? guestInfo,
    DateTime? time,
    DateTime? approveTime,
    bool? isMeet,
  }) {
    return BookingData(
      id: id ?? this.id,
      guestInfo: guestInfo ?? this.guestInfo,
      time: time ?? this.time,
      approveTime: approveTime ?? this.approveTime,
      isMeet: isMeet ?? this.isMeet,
    );
  }
}
