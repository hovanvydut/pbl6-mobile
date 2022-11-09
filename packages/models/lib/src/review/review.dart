import 'package:equatable/equatable.dart';
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
    required this.createdAt,
  });
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  final int id;
  final int postId;
  final User userInfo;
  final String content;
  final int rating;
  final List<Media> medias;
  final DateTime createdAt;

  @override
  List<Object?> get props {
    return [
      id,
      postId,
      userInfo,
      content,
      rating,
      medias,
      createdAt,
    ];
  }
}
