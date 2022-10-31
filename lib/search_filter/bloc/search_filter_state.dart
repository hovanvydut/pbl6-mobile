
part of 'search_filter_bloc.dart';

class SearchFilterState extends Equatable {
  const SearchFilterState({
    this.posts = const [],
    this.provincesData = const [],
    this.districtsData = const [],
    this.wardsData = const [],
    this.houseTypesData = const [],
    this.otherUtilsData = const [],
    this.rentalObjectsData = const [],
    this.priceRange = const RangeValues(1000000, 2000000),
    this.areaRange = const RangeValues(15, 30),
    this.nearbyPlacesData = const [],
    this.selectedDistrict = 0,
    this.selectedWard = 0,
    this.selectedOtherUtils = const [],
    this.selectedRentailObjects = const [],
    this.selectedNearbyPlaces = const [],
    this.loadingStatus = LoadingStatus.initial,
    this.loadingMoreStatus = LoadingStatus.initial,

  });

  final List<Post> posts;
  final List<Province> provincesData;
  final List<District> districtsData;
  final List<Ward> wardsData;
  final List<HouseType> houseTypesData;
  final List<Property> otherUtilsData;
  final List<Property> rentalObjectsData;
  final List<Property> nearbyPlacesData;
  final int selectedDistrict;
  final int selectedWard;
  final List<String> selectedOtherUtils;
  final RangeValues priceRange;
  final RangeValues areaRange;
  final List<String> selectedRentailObjects;
  final List<String> selectedNearbyPlaces;
  final LoadingStatus loadingStatus;
  final LoadingStatus loadingMoreStatus;

  @override
  List<Object?> get props {
    return [
      posts,
      provincesData,
      districtsData,
      wardsData,
      houseTypesData,
      otherUtilsData,
      rentalObjectsData,
      nearbyPlacesData,
      selectedDistrict,
      selectedWard,
      selectedOtherUtils,
      priceRange,
      areaRange,
      selectedRentailObjects,
      selectedNearbyPlaces,
      loadingStatus,
      loadingMoreStatus,
    ];
  }

  SearchFilterState copyWith({
    List<Post>? posts,
    List<Province>? provincesData,
    List<District>? districtsData,
    List<Ward>? wardsData,
    List<HouseType>? houseTypesData,
    List<Property>? otherUtilsData,
    List<Property>? rentalObjectsData,
    List<Property>? nearbyPlacesData,
    int? selectedDistrict,
    int? selectedWard,
    List<String>? selectedOtherUtils,
    RangeValues? priceRange,
    RangeValues? areaRange,
    List<String>? selectedRentailObjects,
    List<String>? selectedNearbyPlaces,
    LoadingStatus? loadingStatus,
    LoadingStatus? loadingMoreStatus,
  }) {
    return SearchFilterState(
      posts: posts ?? this.posts,
      provincesData: provincesData ?? this.provincesData,
      districtsData: districtsData ?? this.districtsData,
      wardsData: wardsData ?? this.wardsData,
      houseTypesData: houseTypesData ?? this.houseTypesData,
      otherUtilsData: otherUtilsData ?? this.otherUtilsData,
      rentalObjectsData: rentalObjectsData ?? this.rentalObjectsData,
      nearbyPlacesData: nearbyPlacesData ?? this.nearbyPlacesData,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedWard: selectedWard ?? this.selectedWard,
      selectedOtherUtils: selectedOtherUtils ?? this.selectedOtherUtils,
      priceRange: priceRange ?? this.priceRange,
      areaRange: areaRange ?? this.areaRange,
      selectedRentailObjects: selectedRentailObjects ?? this.selectedRentailObjects,
      selectedNearbyPlaces: selectedNearbyPlaces ?? this.selectedNearbyPlaces,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      loadingMoreStatus: loadingMoreStatus ?? this.loadingMoreStatus,
    );
  }
}
