import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: false)
class User extends Equatable {
  const User({
    required this.id,
    required this.displayName,
    this.phoneNumber,
    this.identityNumber,
    this.currentCredit,
    required this.avatar,
    required this.address,
    required this.addressWardId,
    required this.addressWard,
    required this.addressDistrict,
    required this.addressProvince,
    this.userAccountId,
    this.userAccountEmail,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String displayName;
  final String? phoneNumber;
  final String? identityNumber;
  final int? currentCredit;
  final String avatar;
  final String address;
  final int addressWardId;
  final String addressWard;
  final String addressDistrict;
  final String addressProvince;
  final int? userAccountId;
  final String? userAccountEmail;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'avatar': avatar,
        'address': address,
        'addressWardId': addressWardId
      };

  @override
  List<Object?> get props {
    return [
      id,
      displayName,
      phoneNumber,
      identityNumber,
      currentCredit,
      address,
      addressWardId,
      addressWard,
      addressDistrict,
      addressProvince,
      userAccountId,
      userAccountEmail,
    ];
  }
}
