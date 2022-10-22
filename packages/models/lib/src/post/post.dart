import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'post.g.dart';

@JsonSerializable(createToJson: false)
class Post extends Equatable {
  const Post({
    required this.id,
    required this.title,
    required this.description,
    required this.area,
    required this.price,
    required this.prePaidPrice,
    required this.slug,
    required this.limitTenant,
    required this.numView,
    required this.address,
    required this.category,
    required this.properties,
    required this.groupProperties,
    required this.medias,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  final int id;
  final String title;
  final String description;
  final int area;
  final int price;
  final int prePaidPrice;
  final String slug;
  final int limitTenant;
  final int numView;
  final Address address;
  final HouseType category;
  final List<Property> properties;
  final List<GroupProperty> groupProperties;
  final List<Media> medias;

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
      category,
      properties,
      groupProperties,
      medias,
    ];
  }
}
