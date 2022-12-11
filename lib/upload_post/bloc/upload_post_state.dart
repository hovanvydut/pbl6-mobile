part of 'upload_post_bloc.dart';

class UploadUserPostState {
  const UploadUserPostState({
    this.title = const LimitLengthField.pure(8),
    this.description = const NotEmptyField.pure(),
    this.provincesData = const <Province>[],
    this.districtsData = const <District>[],
    this.wardsData = const <Ward>[],
    this.houseTypesData = const <HouseType>[],
    this.otherUtilsData = const <Property>[],
    this.rentalObjectsData = const <Property>[],
    this.nearbyPlacesData = const <Property>[],
    this.selectedOtherUtils = const <String>[],
    this.selectedRentailObjects = const <String>[],
    this.selectedNearbyPlaces = const <String>[],
    this.selectedProvince = 0,
    this.selectedDistrict = 0,
    this.selectedWard = 0,
    this.detailAddress = const NotEmptyField.pure(),
    this.selectedHouseType = 0,
    this.price = const NumbericField.pure(),
    this.area = const NumbericField.pure(),
    this.maxOfPerson = const NumbericField.pure(),
    this.diposit = const NumbericField.pure(),
    this.loadingStatus = LoadingStatus.initial,
    this.uploadPostStatus = LoadingStatus.initial,
    this.medias = const <String>[],
    this.formValidationStatus = FormzStatus.pure,
  });

  final LimitLengthField title;
  final NotEmptyField description;
  final List<Province> provincesData;
  final List<District> districtsData;
  final List<Ward> wardsData;
  final List<HouseType> houseTypesData;
  final List<Property> otherUtilsData;
  final List<Property> rentalObjectsData;
  final List<Property> nearbyPlacesData;
  final int selectedProvince;
  final int selectedDistrict;
  final int selectedWard;
  final NotEmptyField detailAddress;
  final int selectedHouseType;
  final NumbericField price;
  final NumbericField area;
  final NumbericField maxOfPerson;
  final NumbericField diposit;
  final List<String> selectedOtherUtils;
  final List<String> selectedRentailObjects;
  final List<String> selectedNearbyPlaces;
  final LoadingStatus loadingStatus;
  final LoadingStatus uploadPostStatus;
  final List<String> medias;
  final FormzStatus formValidationStatus;

  // @override
  // List<Object?> get props {
  //   return [
  //     title,
  //     description,
  //     provincesData,
  //     districtsData,
  //     wardsData,
  //     houseTypesData,
  //     otherUtilsData,
  //     rentalObjectsData,
  //     nearbyPlacesData,
  //     selectedProvince,
  //     selectedDistrict,
  //     selectedWard,
  //     detailAddress,
  //     selectedHouseType,
  //     price,
  //     area,
  //     maxOfPerson,
  //     diposit,
  //     selectedOtherUtils,
  //     selectedRentailObjects,
  //     selectedNearbyPlaces,
  //     loadingStatus,
  //   ];
  // }

  UploadUserPostState copyWith({
    LimitLengthField? title,
    NotEmptyField? description,
    List<Province>? provincesData,
    List<District>? districtsData,
    List<Ward>? wardsData,
    List<HouseType>? houseTypesData,
    List<Property>? otherUtilsData,
    List<Property>? rentalObjectsData,
    List<Property>? nearbyPlacesData,
    int? selectedProvince,
    int? selectedDistrict,
    int? selectedWard,
    NotEmptyField? detailAddress,
    int? selectedHouseType,
    NumbericField? price,
    NumbericField? area,
    NumbericField? maxOfPerson,
    NumbericField? diposit,
    List<String>? selectedOtherUtils,
    List<String>? selectedRentailObjects,
    List<String>? selectedNearbyPlaces,
    List<String>? medias,
    LoadingStatus? loadingStatus,
    LoadingStatus? uploadPostStatus,
    FormzStatus? formValidationStatus,
  }) {
    return UploadUserPostState(
      title: title ?? this.title,
      description: description ?? this.description,
      provincesData: provincesData ?? this.provincesData,
      districtsData: districtsData ?? this.districtsData,
      wardsData: wardsData ?? this.wardsData,
      houseTypesData: houseTypesData ?? this.houseTypesData,
      otherUtilsData: otherUtilsData ?? this.otherUtilsData,
      rentalObjectsData: rentalObjectsData ?? this.rentalObjectsData,
      nearbyPlacesData: nearbyPlacesData ?? this.nearbyPlacesData,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedWard: selectedWard ?? this.selectedWard,
      detailAddress: detailAddress ?? this.detailAddress,
      selectedHouseType: selectedHouseType ?? this.selectedHouseType,
      price: price ?? this.price,
      area: area ?? this.area,
      maxOfPerson: maxOfPerson ?? this.maxOfPerson,
      diposit: diposit ?? this.diposit,
      selectedOtherUtils: selectedOtherUtils ?? this.selectedOtherUtils,
      selectedRentailObjects:
          selectedRentailObjects ?? this.selectedRentailObjects,
      selectedNearbyPlaces: selectedNearbyPlaces ?? this.selectedNearbyPlaces,
      uploadPostStatus: uploadPostStatus ?? this.uploadPostStatus,
      medias: medias ?? this.medias,
      formValidationStatus: formValidationStatus ?? this.formValidationStatus,
    );
  }
}
