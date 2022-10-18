part of 'upload_post_bloc.dart';

abstract class UploadPostEvent extends Equatable {
  const UploadPostEvent();

  @override
  List<Object?> get props => [];
}

class PageStarted extends UploadPostEvent {}

class TitleChanged extends UploadPostEvent {
  const TitleChanged(this.title);

  final String title;

  @override
  List<Object?> get props => [title];
}

class SummaryDescriptionChanged extends UploadPostEvent {
  const SummaryDescriptionChanged(this.description);

  final String description;

  @override
  List<Object?> get props => [description];
}

class ProvinceSelected extends UploadPostEvent {
  const ProvinceSelected(this.province);

  final String province;

  @override
  List<Object?> get props => [province];
}

class DistrictSelected extends UploadPostEvent {
  const DistrictSelected(this.district);

  final String district;

  @override
  List<Object?> get props => [district];
}

class WardSelected extends UploadPostEvent {
  const WardSelected(this.ward);

  final String ward;

  @override
  List<Object?> get props => [ward];
}

class DetailAddressChanged extends UploadPostEvent {
  const DetailAddressChanged(this.address);

  final String address;

  @override
  List<Object?> get props => [address];
}

class RoomTypeSelected extends UploadPostEvent {
  const RoomTypeSelected(this.roomType);

  final String roomType;

  @override
  List<Object?> get props => [roomType];
}

class RoomPriceChanged extends UploadPostEvent {
  const RoomPriceChanged(this.price);

  final String price;

  @override
  List<Object?> get props => [price];
}

class RoomAreaChanged extends UploadPostEvent {
  const RoomAreaChanged(this.area);

  final String area;

  @override
  List<Object?> get props => [area];
}

class MaxOfPersonChanged extends UploadPostEvent {
  const MaxOfPersonChanged(this.maxOfPerson);

  final String maxOfPerson;

  @override
  List<Object?> get props => [maxOfPerson];
}

class DipositChanged extends UploadPostEvent {
  const DipositChanged(this.diposit);

  final String diposit;

  @override
  List<Object?> get props => [diposit];
}

class OtherUtilitiesSelected extends UploadPostEvent {
  const OtherUtilitiesSelected(this.utilities);

  final List<String> utilities;

  @override
  List<Object?> get props => [utilities];
}

class RentalObjectsSelected extends UploadPostEvent {
  const RentalObjectsSelected(this.rentailObjects);

  final List<String> rentailObjects;

  @override
  List<Object?> get props => [rentailObjects];
}

class NearbyPlacesSelected extends UploadPostEvent {
  const NearbyPlacesSelected(this.nearbyPlaces);

  final List<String> nearbyPlaces;

  @override
  List<Object?> get props => [nearbyPlaces];
}

class MediaSelected extends UploadPostEvent {}

class UploadPostSubmiited extends UploadPostEvent {
  
}
