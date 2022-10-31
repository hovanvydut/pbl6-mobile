import 'dart:async';

import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:post/post.dart';
import 'package:property/property.dart';

part 'search_filter_event.dart';
part 'search_filter_state.dart';

class SearchFilterBloc extends Bloc<SearchFilterEvent, SearchFilterState> {
  SearchFilterBloc({
    required AddressRepository addressRepository,
    required CategoryRepository categoryRepository,
    required PropertyRepository propertyRepository,
    required PostRepository postRepository,
  })  : _addressRepository = addressRepository,
        _categoryRepository = categoryRepository,
        _propertyRepository = propertyRepository,
        _postRepository = postRepository,
        super(const SearchFilterState()) {
    on<SearchPageStarted>(_onSearchPageStarted);
    on<HouseTypeSeleted>(_onHouseTypeSelected);
    on<PriceChanged>(_onPriceChanged);
    on<AreaRangeChanged>(_onAreaRangeChanged);
    on<WardSelected>(_onWardSelected);
    on<OtherUtilitiesSelected>(_onUtilSelected);
    on<RentalObjectsSelected>(_onObjectSelected);
    on<NearbyPlacesSelected>(_onPlacesSelected);
    on<SearchChanged>(_onSearchChanged);
    on<FilterSubmitted>(_onFilterSubmiited);
    on<RemoveSearchFilterPressed>(_onRemoveSearchFilterPressed);
    add(SearchPageStarted());
  }

  final AddressRepository _addressRepository;
  final CategoryRepository _categoryRepository;
  final PropertyRepository _propertyRepository;
  final PostRepository _postRepository;

  int pageNumber = 1;

  Future<void> _onSearchPageStarted(
    SearchPageStarted event,
    Emitter<SearchFilterState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final fetchedProvinces = await _addressRepository.getProvinces();
      final fetchedHouseTypes = await _categoryRepository.getHouseTypes();
      final fetchedProperties = await _propertyRepository.getGroupProperties();
      final fetchedPosts = await _postRepository.filterPosts();
      emit(
        state.copyWith(
          posts: fetchedPosts,
          provincesData: fetchedProvinces,
          houseTypesData: fetchedHouseTypes,
          otherUtilsData: fetchedProperties[PropertyType.util]!.properties,
          rentalObjectsData: fetchedProperties[PropertyType.rental]!.properties,
          nearbyPlacesData: fetchedProperties[PropertyType.nearby]!.properties,
          loadingStatus: LoadingStatus.done,
        ),
      );
      pageNumber++;
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }
  }

  void _onHouseTypeSelected(
    HouseTypeSeleted event,
    Emitter<SearchFilterState> emit,
  ) {}

  void _onPriceChanged(
    PriceChanged event,
    Emitter<SearchFilterState> emit,
  ) {}

  void _onAreaRangeChanged(
    AreaRangeChanged event,
    Emitter<SearchFilterState> emit,
  ) {}

  void _onWardSelected(
    WardSelected event,
    Emitter<SearchFilterState> emit,
  ) {}

  void _onUtilSelected(
    OtherUtilitiesSelected event,
    Emitter<SearchFilterState> emit,
  ) {}

  void _onObjectSelected(
    RentalObjectsSelected event,
    Emitter<SearchFilterState> emit,
  ) {}

  void _onPlacesSelected(
    NearbyPlacesSelected event,
    Emitter<SearchFilterState> emit,
  ) {}

  void _onSearchChanged(
    SearchChanged event,
    Emitter<SearchFilterState> emit,
  ) {}

  void _onFilterSubmiited(
    FilterSubmitted event,
    Emitter<SearchFilterState> emit,
  ) {}

  void _onRemoveSearchFilterPressed(
    RemoveSearchFilterPressed event,
    Emitter<SearchFilterState> emit,
  ) {}
}
