part of 'edit_post_bloc.dart';

class EditUserPostState {
  const EditUserPostState({
    this.title = '',
    this.description = '',
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
    this.detailAddress = '',
    this.selectedHouseType = 0,
    this.price = 0,
    this.area = 0.0,
    this.maxOfPerson = 0,
    this.diposit = 0,
    this.loadingStatus = LoadingStatus.initial,
    this.editPostStatus = LoadingStatus.initial,
    this.medias = const <String>[],
  });

  final String title;
  final String description;
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
  final String detailAddress;
  final int selectedHouseType;
  final double price;
  final double area;
  final int maxOfPerson;
  final double diposit;
  final List<String> selectedOtherUtils;
  final List<String> selectedRentailObjects;
  final List<String> selectedNearbyPlaces;
  final LoadingStatus loadingStatus;
  final LoadingStatus editPostStatus;
  final List<String> medias;

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

  EditUserPostState copyWith({
    String? title,
    String? description,
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
    String? detailAddress,
    int? selectedHouseType,
    double? price,
    double? area,
    int? maxOfPerson,
    double? diposit,
    List<String>? selectedOtherUtils,
    List<String>? selectedRentailObjects,
    List<String>? selectedNearbyPlaces,
    List<String>? medias,
    LoadingStatus? loadingStatus,
    LoadingStatus? editPostStatus,
  }) {
    return EditUserPostState(
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
      editPostStatus: editPostStatus ?? this.editPostStatus,
      medias: medias ?? this.medias,
    );
  }
}
