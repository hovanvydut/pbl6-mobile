
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
    this.nearbyPlacesData = const [],
    this.priceRange = const RangeValues(500000, 15000000),
    this.areaRange = const RangeValues(0, 30),
    this.selectedDistrict = 0,
    this.houseTypeSelected = 0,
    this.selectedWard = 0,
    this.selectedOtherUtils = const [],
    this.selectedRentailObjects = const [],
    this.selectedNearbyPlaces = const [],
    this.loadingStatus = LoadingStatus.initial,
    this.loadingMoreStatus = LoadingStatus.initial,
    this.isInitialFilter = true,
    this.searchValue = '',
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
  final int houseTypeSelected;
  final List<int> selectedOtherUtils;
  final RangeValues priceRange;
  final RangeValues areaRange;
  final List<int> selectedRentailObjects;
  final List<int> selectedNearbyPlaces;
  final LoadingStatus loadingStatus;
  final bool isInitialFilter;
  final LoadingStatus loadingMoreStatus;
  final String searchValue;

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
      houseTypeSelected,
      selectedOtherUtils,
      priceRange,
      areaRange,
      selectedRentailObjects,
      selectedNearbyPlaces,
      loadingStatus,
      isInitialFilter,
      loadingMoreStatus,
      searchValue,
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
    int? houseTypeSelected,
    List<int>? selectedOtherUtils,
    RangeValues? priceRange,
    RangeValues? areaRange,
    List<int>? selectedRentailObjects,
    List<int>? selectedNearbyPlaces,
    LoadingStatus? loadingStatus,
    bool? isInitialFilter,
    LoadingStatus? loadingMoreStatus,
    String? searchValue,
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
      houseTypeSelected: houseTypeSelected ?? this.houseTypeSelected,
      selectedOtherUtils: selectedOtherUtils ?? this.selectedOtherUtils,
      priceRange: priceRange ?? this.priceRange,
      areaRange: areaRange ?? this.areaRange,
      selectedRentailObjects: selectedRentailObjects ?? this.selectedRentailObjects,
      selectedNearbyPlaces: selectedNearbyPlaces ?? this.selectedNearbyPlaces,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      isInitialFilter: isInitialFilter ?? this.isInitialFilter,
      loadingMoreStatus: loadingMoreStatus ?? this.loadingMoreStatus,
      searchValue: searchValue ?? this.searchValue,
    );
  }
}
