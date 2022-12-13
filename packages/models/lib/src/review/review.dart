import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'review.g.dart';

@JsonSerializable(createToJson: false)
class Review extends Equatable {
  const Review({
    required this.id,
    required this.postId,
    required this.userInfo,
    required this.content,
    required this.rating,
    required this.medias,
    this.sentiment,
    required this.createdAt,
  });
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  final int id;
  final int postId;
  final User userInfo;
  final String content;
  final int rating;
  final List<Media> medias;
  final Sentiment? sentiment;
  @JsonKey(fromJson: _fromJson)
  final DateTime createdAt;

  static DateTime _fromJson(String date) =>
      DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date, true);

  @override
  List<Object?> get props {
    return [
      id,
      postId,
      userInfo,
      content,
      rating,
      medias,
      sentiment,
      createdAt,
    ];
  }
}
