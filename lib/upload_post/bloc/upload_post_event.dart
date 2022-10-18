part of 'upload_post_bloc.dart';

abstract class UploadPostEvent extends Equatable {
  const UploadPostEvent();

  @override
  List<Object?> get props => [];
}

class TitleChanged extends UploadPostEvent {
  
}

class SummaryDescriptionChanged extends UploadPostEvent {}

class ProvinceSelected extends UploadPostEvent {}

class DistrictSelected extends UploadPostEvent {}

class WardSelected extends UploadPostEvent {}

class DetailAddressChanged extends UploadPostEvent {}

class RoomTypeSelected extends UploadPostEvent {}

class RoomPriceChanged extends UploadPostEvent {}

class RoomAreaChanged extends UploadPostEvent {}

class MaxOfPersonChanged extends UploadPostEvent {}

class DipositChanged extends UploadPostEvent {}

class OtherUtilitiesSelected extends UploadPostEvent {}

class RentalObjectsSelected extends UploadPostEvent {}

class NearbyPlacesSelected extends UploadPostEvent {}

class MediaSelected extends UploadPostEvent {}

class UploadPostSubmiited extends UploadPostEvent {}
