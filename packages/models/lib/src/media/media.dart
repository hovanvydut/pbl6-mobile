import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable()
class Media extends Equatable {
  const Media({required this.url, this.contentType});
  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
  final String url;
  final String? contentType;

  Map<String, dynamic> toJson() => _$MediaToJson(this);

  @override
  List<Object?> get props => [url, contentType];
}
