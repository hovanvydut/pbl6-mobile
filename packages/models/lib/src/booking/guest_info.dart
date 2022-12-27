import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guest_info.g.dart';

@JsonSerializable(createToJson: false)
class GuestInfo extends Equatable {
  const GuestInfo({
    required this.id,
    required this.displayName,
    required this.avatar,
    required this.phoneNumber,
  });
  factory GuestInfo.fromJson(Map<String, dynamic> json) =>
      _$GuestInfoFromJson(json);

  final int id;
  final String displayName;
  final String? avatar;
  final String? phoneNumber;

  @override
  List<Object?> get props => [id, displayName, avatar, phoneNumber];
}
