import 'dart:async';

import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:dartx/dartx.dart';
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
    on<GetPosts>(_onGetPosts);
    on<HouseTypeSelected>(_onHouseTypeSelected);
    on<PriceRangeChanged>(_onPriceChanged);
    on<AreaRangeChanged>(_onAreaRangeChanged);
    on<DistrictSelected>(_onDistrictSelected);
    on<WardSelected>(_onWardSelected);
    on<OtherUtilSelected>(_onUtilSelected);
    on<RentalObjectSelected>(_onObjectSelected);
    on<NearbyPlaceSelected>(_onPlaceSelected);
    on<SearchChanged>(_onSearchChanged);
    on<ScrollMoreReached>(_onScrollMoreReached);
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
      final fetchedDistricts =
          await _addressRepository.getDistrictsByProvinceId(32);
      emit(
        state.copyWith(
          districtsData: fetchedDistricts,
        ),
      );
      final fetchedHouseTypes = await _categoryRepository.getHouseTypes();
      final fetchedProperties = await _propertyRepository.getGroupProperties();
      final fetchedPosts = await _postRepository.filterPosts();
      emit(
        state.copyWith(
          posts: fetchedPosts,
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

  Future<void> _onGetPosts(
    GetPosts event,
    Emitter<SearchFilterState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final fetchedPosts = await _postRepository.filterPosts();
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.done,
          posts: fetchedPosts,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }
  }

  void _onHouseTypeSelected(
    HouseTypeSelected event,
    Emitter<SearchFilterState> emit,
  ) {
    if (state.houseTypeSelected == event.categoryId) {
      emit(
        state.copyWith(
          houseTypeSelected: 0,
          isInitialFilter: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        houseTypeSelected: event.categoryId,
        isInitialFilter: false,
      ),
    );
  }

  void _onPriceChanged(
    PriceRangeChanged event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(state.copyWith(priceRange: event.priceRange));
  }

  void _onAreaRangeChanged(
    AreaRangeChanged event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(state.copyWith(areaRange: event.areaRange));
  }

  Future<void> _onDistrictSelected(
    DistrictSelected event,
    Emitter<SearchFilterState> emit,
  ) async {
    final districtId = int.parse(event.district);

    emit(state.copyWith(selectedDistrict: districtId));
    if (districtId != 0) {
      final fetchedWards =
          await _addressRepository.getWardsByDistrictId(districtId);
      emit(
        state.copyWith(
          wardsData: fetchedWards,
          isInitialFilter: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        wardsData: [],
        isInitialFilter: false,
      ),
    );
  }

  void _onWardSelected(
    WardSelected event,
    Emitter<SearchFilterState> emit,
  ) {
    final wardId = int.parse(event.ward);
    emit(
      state.copyWith(
        selectedWard: wardId,
        isInitialFilter: false,
      ),
    );
  }

  void _onUtilSelected(
    OtherUtilSelected event,
    Emitter<SearchFilterState> emit,
  ) {
    final isUtilExisted = state.selectedOtherUtils.any(
      (util) => util == event.utilId,
    );
    if (isUtilExisted) {
      emit(
        state.copyWith(
          selectedOtherUtils: state.selectedOtherUtils
              .where(
                (util) => util != event.utilId,
              )
              .toList(),
          isInitialFilter: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        selectedOtherUtils: [...state.selectedOtherUtils, event.utilId],
        isInitialFilter: false,
      ),
    );
  }

  void _onObjectSelected(
    RentalObjectSelected event,
    Emitter<SearchFilterState> emit,
  ) {
    final isObjExisted = state.selectedRentailObjects.any(
      (obj) => obj == event.obj,
    );
    if (isObjExisted) {
      emit(
        state.copyWith(
          selectedRentailObjects: state.selectedRentailObjects
              .where(
                (obj) => obj != event.obj,
              )
              .toList(),
          isInitialFilter: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        selectedRentailObjects: [...state.selectedRentailObjects, event.obj],
        isInitialFilter: false,
      ),
    );
  }

  void _onPlaceSelected(
    NearbyPlaceSelected event,
    Emitter<SearchFilterState> emit,
  ) {
    final isPlaceExisted = state.selectedNearbyPlaces.any(
      (place) => place == event.place,
    );
    if (isPlaceExisted) {
      emit(
        state.copyWith(
          selectedNearbyPlaces: state.selectedNearbyPlaces
              .where(
                (place) => place != event.place,
              )
              .toList(),
          isInitialFilter: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        selectedNearbyPlaces: [...state.selectedNearbyPlaces, event.place],
        isInitialFilter: false,
      ),
    );
  }

  Future<void> _onSearchChanged(
    SearchChanged event,
    Emitter<SearchFilterState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final properties = [
        ...state.selectedRentailObjects,
        ...state.selectedNearbyPlaces,
        ...state.selectedOtherUtils
      ];
      final filteredPost = await _postRepository.filterPosts(
        addressWardId: state.selectedWard == 0 ? null : state.selectedWard,
        categoryId:
            state.houseTypeSelected == 0 ? null : state.houseTypeSelected,
        maxArea: state.areaRange == const RangeValues(0, 30)
            ? null
            : state.areaRange.end,
        minArea: state.areaRange == const RangeValues(0, 30)
            ? null
            : state.areaRange.start,
        maxPrice: state.priceRange == const RangeValues(500000, 15000000)
            ? null
            : state.priceRange.end,
        minPrice: state.priceRange == const RangeValues(500000, 15000000)
            ? null
            : state.priceRange.start,
        properties: properties.isEmpty ? null : properties,
        searchValue: event.value.isNullOrBlank ? null : event.value,
      );
      emit(
        state.copyWith(
          posts: filteredPost,
          loadingStatus: LoadingStatus.done,
        ),
      );
      if (filteredPost.isNotEmpty) {
        pageNumber = 2;
      }
    } catch (e) {
      addError(e);
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
        ),
      );
    }
  }

  Future<void> _onFilterSubmiited(
    FilterSubmitted event,
    Emitter<SearchFilterState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final properties = [
        ...state.selectedRentailObjects,
        ...state.selectedNearbyPlaces,
        ...state.selectedOtherUtils
      ];
      final filteredPost = await _postRepository.filterPosts(
        addressWardId: state.selectedWard == 0 ? null : state.selectedWard,
        categoryId:
            state.houseTypeSelected == 0 ? null : state.houseTypeSelected,
        maxArea: state.areaRange == const RangeValues(0, 30)
            ? null
            : state.areaRange.end,
        minArea: state.areaRange == const RangeValues(0, 30)
            ? null
            : state.areaRange.start,
        maxPrice: state.priceRange == const RangeValues(500000, 15000000)
            ? null
            : state.priceRange.end,
        minPrice: state.priceRange == const RangeValues(500000, 15000000)
            ? null
            : state.priceRange.start,
        properties: properties.isEmpty ? null : properties,
      );
      emit(
        state.copyWith(
          posts: filteredPost,
          loadingStatus: LoadingStatus.done,
        ),
      );
      if (filteredPost.isNotEmpty) {
        pageNumber = 2;
      }
    } catch (e) {
      addError(e);
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
        ),
      );
    }
  }

  void _onRemoveSearchFilterPressed(
    RemoveSearchFilterPressed event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(
      state.copyWith(
        priceRange: const RangeValues(500000, 15000000),
        areaRange: const RangeValues(0, 30),
        selectedDistrict: 0,
        houseTypeSelected: 0,
        selectedWard: 0,
        selectedOtherUtils: const [],
        selectedRentailObjects: const [],
        selectedNearbyPlaces: const [],
        isInitialFilter: true,
      ),
    );
    add(GetPosts());
  }

  Future<void> _onScrollMoreReached(
    ScrollMoreReached event,
    Emitter<SearchFilterState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingMoreStatus: LoadingStatus.loading));
      final properties = [
        ...state.selectedRentailObjects,
        ...state.selectedNearbyPlaces,
        ...state.selectedOtherUtils
      ];
      final morePosts = await _postRepository.filterPosts(
        addressWardId: state.selectedWard == 0 ? null : state.selectedWard,
        categoryId:
            state.houseTypeSelected == 0 ? null : state.houseTypeSelected,
        maxArea: state.areaRange == const RangeValues(0, 30)
            ? null
            : state.areaRange.end,
        minArea: state.areaRange == const RangeValues(0, 30)
            ? null
            : state.areaRange.start,
        maxPrice: state.priceRange == const RangeValues(500000, 15000000)
            ? null
            : state.priceRange.end,
        minPrice: state.priceRange == const RangeValues(500000, 15000000)
            ? null
            : state.priceRange.start,
        properties: properties.isEmpty ? null : properties,
        pageNumber: pageNumber,
      );
      if (morePosts.isNotEmpty) {
        pageNumber++;
      }
      emit(
        state.copyWith(
          loadingMoreStatus: LoadingStatus.done,
          posts: [...state.posts, ...morePosts],
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(loadingMoreStatus: LoadingStatus.error));
    }
  }
}
