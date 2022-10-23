// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_post_bloc.dart';

abstract class EditPostEvent extends Equatable {
  const EditPostEvent();

  @override
  List<Object?> get props => [];
}

class EditPageStarted extends EditPostEvent {
  const EditPageStarted(this.post);
  final Post post;

  @override
  List<Object?> get props => [post];
}

class TitleChanged extends EditPostEvent {
  const TitleChanged(this.title);

  final String title;

  @override
  List<Object?> get props => [title];
}

class SummaryDescriptionChanged extends EditPostEvent {
  const SummaryDescriptionChanged(this.description);

  final String description;

  @override
  List<Object?> get props => [description];
}

class ProvinceSelected extends EditPostEvent {
  const ProvinceSelected(this.province);

  final String province;

  @override
  List<Object?> get props => [province];
}

class DistrictSelected extends EditPostEvent {
  const DistrictSelected(this.district);

  final String district;

  @override
  List<Object?> get props => [district];
}

class WardSelected extends EditPostEvent {
  const WardSelected(this.ward);

  final String ward;

  @override
  List<Object?> get props => [ward];
}

class DetailAddressChanged extends EditPostEvent {
  const DetailAddressChanged(this.address);

  final String address;

  @override
  List<Object?> get props => [address];
}

class HouseTypeSelected extends EditPostEvent {
  const HouseTypeSelected(this.houseType);

  final String houseType;

  @override
  List<Object?> get props => [houseType];
}

class RoomPriceChanged extends EditPostEvent {
  const RoomPriceChanged(this.price);

  final num price;

  @override
  List<Object?> get props => [price];
}

class RoomAreaChanged extends EditPostEvent {
  const RoomAreaChanged(this.area);

  final String area;

  @override
  List<Object?> get props => [area];
}

class MaxOfPersonChanged extends EditPostEvent {
  const MaxOfPersonChanged(this.maxOfPerson);

  final String maxOfPerson;

  @override
  List<Object?> get props => [maxOfPerson];
}

class DipositChanged extends EditPostEvent {
  const DipositChanged(this.diposit);

  final num diposit;

  @override
  List<Object?> get props => [diposit];
}

class OtherUtilitiesSelected extends EditPostEvent {
  const OtherUtilitiesSelected(this.utilities);

  final List<String> utilities;

  @override
  List<Object?> get props => [utilities];
}

class RentalObjectsSelected extends EditPostEvent {
  const RentalObjectsSelected(this.rentailObjects);

  final List<String> rentailObjects;

  @override
  List<Object?> get props => [rentailObjects];
}

class NearbyPlacesSelected extends EditPostEvent {
  const NearbyPlacesSelected(this.nearbyPlaces);

  final List<String> nearbyPlaces;

  @override
  List<Object?> get props => [nearbyPlaces];
}

class MediaSelected extends EditPostEvent {}

class MediaRemovePressed extends EditPostEvent {
  const MediaRemovePressed(this.media);

  final String media;

  @override
  List<Object?> get props => [media];
}

class EditPostSubmitted extends EditPostEvent {
  const EditPostSubmitted({
    required this.post,
  });
  final Post post;

  @override
  List<Object?> get props => [post];
}
