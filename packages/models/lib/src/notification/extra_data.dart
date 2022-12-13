import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extra_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ExtraData extends Equatable {
  const ExtraData({
    required this.postId,
    required this.postTitle,
    this.bookingId,
    this.reviewId,
    this.reviewContent,
    this.reviewRating,
    this.bookingTime,
  });
  factory ExtraData.fromJson(Map<String, dynamic> json) =>
      _$ExtraDataFromJson(json);

  final int postId;
  final String postTitle;
  final int? bookingId;
  final int? reviewId;
  final String? reviewContent;
  final int? reviewRating;
  @JsonKey(fromJson: _fromJson)
  final DateTime? bookingTime;

  static DateTime? _fromJson(String? data) =>
      data == null ? null : DateFormat('yyyy-MM-ddTHH:mm:ss').parse(data, true);

  @override
  List<Object?> get props {
    return [
      postId,
      postTitle,
      bookingId,
      reviewId,
      reviewContent,
      reviewRating,
      bookingTime,
    ];
  }
}
