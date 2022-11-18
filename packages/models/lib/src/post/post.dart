import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'post.g.dart';

@JsonSerializable(createToJson: false)
class Post extends Equatable {
  const Post({
    required this.id,
    required this.title,
    this.description,
    required this.area,
    required this.price,
    this.prePaidPrice,
    this.slug,
    this.limitTenant,
    this.numView,
    required this.address,
    required this.fullAddress,
    required this.category,
    required this.properties,
    this.groupProperties,
   this.averageRating,
    required this.medias,
    this.authorInfo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  final int id;
  final String title;
  final String? description;
  final double area;
  final double price;
  final double? prePaidPrice;
  final String? slug;
  final int? limitTenant;
  final int? numView;
  final String address;
  final Address fullAddress;
  final HouseType category;
  final List<Property>? properties;
  @JsonKey(name: 'propertyGroup')
  final List<GroupProperty>? groupProperties;
  final List<Media> medias;
  final double? averageRating;
  final User? authorInfo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      area,
      price,
      prePaidPrice,
      slug,
      limitTenant,
      numView,
      address,
      fullAddress,
      category,
      properties,
      groupProperties,
      medias,
      averageRating,
      authorInfo,
      createdAt,
      updatedAt,
    ];
  }

  Post copyWith({
    int? id,
    String? title,
    String? description,
    double? area,
    double? price,
    double? prePaidPrice,
    String? slug,
    int? limitTenant,
    int? numView,
    String? address,
    Address? fullAddress,
    HouseType? category,
    List<Property>? properties,
    List<GroupProperty>? groupProperties,
    List<Media>? medias,
    double? averageRating,
    User? authorInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      area: area ?? this.area,
      price: price ?? this.price,
      prePaidPrice: prePaidPrice ?? this.prePaidPrice,
      slug: slug ?? this.slug,
      limitTenant: limitTenant ?? this.limitTenant,
      numView: numView ?? this.numView,
      address: address ?? this.address,
      fullAddress: fullAddress ?? this.fullAddress,
      category: category ?? this.category,
      properties: properties ?? this.properties,
      groupProperties: groupProperties ?? this.groupProperties,
      medias: medias ?? this.medias,
      averageRating: averageRating ?? this.averageRating,
      authorInfo: authorInfo ?? this.authorInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
