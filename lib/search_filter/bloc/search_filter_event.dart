part of 'search_filter_bloc.dart';

abstract class SearchFilterEvent extends Equatable {
  const SearchFilterEvent();

  @override
  List<Object?> get props => [];
}

class SearchPageStarted extends SearchFilterEvent {}

class HouseTypeSeleted extends SearchFilterEvent {}

class PriceChanged extends SearchFilterEvent {
  const PriceChanged(this.priceRange);

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

class OtherUtilitiesSelected extends SearchFilterEvent {
  const OtherUtilitiesSelected(this.utilities);

  final List<String> utilities;

  @override
  List<Object?> get props => [utilities];
}

class RentalObjectsSelected extends SearchFilterEvent {
  const RentalObjectsSelected(this.rentailObjects);

  final List<String> rentailObjects;

  @override
  List<Object?> get props => [rentailObjects];
}

class NearbyPlacesSelected extends SearchFilterEvent {
  const NearbyPlacesSelected(this.nearbyPlaces);

  final List<String> nearbyPlaces;

  @override
  List<Object?> get props => [nearbyPlaces];
}

class SearchChanged extends SearchFilterEvent {
  const SearchChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class FilterSubmitted extends SearchFilterEvent {}

class RemoveSearchFilterPressed extends SearchFilterEvent {}
