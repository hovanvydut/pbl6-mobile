part of 'upload_post_bloc.dart';

class UploadPostState extends Equatable {
  const UploadPostState({
    this.title = '',
    this.description = '',
    this.provincesData = const [],
    this.districtsData = const [],
    this.wardsData = const [],
    this.houseTypesData = const [],
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
  });

  final String title;
  final String description;
  final List<Province> provincesData;
  final List<District> districtsData;
  final List<Ward> wardsData;
  final List<HouseType> houseTypesData;
  final int selectedProvince;
  final int selectedDistrict;
  final int selectedWard;
  final String detailAddress;
  final int selectedHouseType;
  final int price;
  final double area;
  final int maxOfPerson;
  final int diposit;
  final LoadingStatus loadingStatus;

  @override
  List<Object> get props {
    return [
      title,
      description,
      provincesData,
      districtsData,
      wardsData,
      houseTypesData,
      selectedProvince,
      selectedDistrict,
      selectedWard,
      detailAddress,
      selectedHouseType,
      price,
      area,
      maxOfPerson,
      diposit,
      loadingStatus,
    ];
  }

  UploadPostState copyWith({
    String? title,
    String? description,
    List<Province>? provincesData,
    List<District>? districtsData,
    List<Ward>? wardsData,
    List<HouseType>? houseTypesData,
    int? selectedProvince,
    int? selectedDistrict,
    int? selectedWard,
    String? detailAddress,
    int? selectedHouseType,
    int? price,
    double? area,
    int? maxOfPerson,
    int? diposit,
    LoadingStatus? loadingStatus,
  }) {
    return UploadPostState(
      title: title ?? this.title,
      description: description ?? this.description,
      provincesData: provincesData ?? this.provincesData,
      districtsData: districtsData ?? this.districtsData,
      wardsData: wardsData ?? this.wardsData,
      houseTypesData: houseTypesData ?? this.houseTypesData,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedWard: selectedWard ?? this.selectedWard,
      detailAddress: detailAddress ?? this.detailAddress,
      selectedHouseType: selectedHouseType ?? this.selectedHouseType,
      price: price ?? this.price,
      area: area ?? this.area,
      maxOfPerson: maxOfPerson ?? this.maxOfPerson,
      diposit: diposit ?? this.diposit,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
