part of 'search_filter_bloc.dart';

abstract class SearchFilterEvent extends Equatable {
  const SearchFilterEvent();

  @override
  List<Object?> get props => [];
}

class SearchPageStarted extends SearchFilterEvent {}

class GetPosts extends SearchFilterEvent {}

class ScrollMoreReached extends SearchFilterEvent {}

class HouseTypeSelected extends SearchFilterEvent {
  const HouseTypeSelected(this.categoryId);

  final int categoryId;

  @override
  List<Object?> get props => [categoryId];
}

class PriceRangeChanged extends SearchFilterEvent {
  const PriceRangeChanged(this.priceRange);

  final RangeValues priceRange;

  @override
  List<Object> get props => [priceRange];
}

class AreaRangeChanged extends SearchFilterEvent {
  const AreaRangeChanged(this.areaRange);

  final RangeValues areaRange;

  @override
  List<Object> get props => [areaRange];
}

class DistrictSelected extends SearchFilterEvent {
  const DistrictSelected(this.district);

  final String district;

  @override
  List<Object?> get props => [district];
}

class WardSelected extends SearchFilterEvent {
  const WardSelected(this.ward);

  final String ward;

  @override
  List<Object?> get props => [ward];
}

class OtherUtilSelected extends SearchFilterEvent {
  const OtherUtilSelected(this.utilId);

  final int utilId;

  @override
  List<Object?> get props => [utilId];
}

class RentalObjectSelected extends SearchFilterEvent {
  const RentalObjectSelected(this.obj);

  final int obj;

  @override
  List<Object?> get props => [obj];
}

class NearbyPlaceSelected extends SearchFilterEvent {
  const NearbyPlaceSelected(this.place);

  final int place;

  @override
  List<Object?> get props => [place];
}

class SearchChanged extends SearchFilterEvent {
  const SearchChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class FilterSubmitted extends SearchFilterEvent {}

class RemoveSearchFilterPressed extends SearchFilterEvent {}
