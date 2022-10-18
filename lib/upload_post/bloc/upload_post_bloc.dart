import 'dart:async';

import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';

part 'upload_post_event.dart';
part 'upload_post_state.dart';

class UploadPostBloc extends Bloc<UploadPostEvent, UploadPostState> {
  UploadPostBloc({
    required AddressRepository addressRepository,
    required CategoryRepository categoryRepository,
  })  : _addressRepository = addressRepository,
        _categoryRepository = categoryRepository,
        super(const UploadPostState()) {
    on<PageStarted>(_onPageStart);
    on<TitleChanged>(_onTitleChanged);
    on<SummaryDescriptionChanged>(_onDescriptionChanged);
    on<ProvinceSelected>(_onProvinceSelected);
    on<DistrictSelected>(_onDistrictSelected);
    on<WardSelected>(_onWardSelected);
    on<DetailAddressChanged>(_onDetailAddressChanged);
    on<RoomTypeSelected>(_onRoomTypeSelected);
    on<RoomPriceChanged>(_onRoomPriceChanged);
    on<RoomAreaChanged>(_onRoomAreaChanged);
    on<MaxOfPersonChanged>(_onMaxOfPersonChanged);
    on<DipositChanged>(_onDipositChanged);
    on<OtherUtilitiesSelected>(_onOtherUtilitiesSelected);
    on<RentalObjectsSelected>(_onRentalObjectsSelected);
    on<NearbyPlacesSelected>(_onNearbyPlacesSelected);
    on<MediaSelected>(_onMediaSelected);
    on<UploadPostSubmiited>(_onUploadPostSubmiited);
    add(PageStarted());
  }

  final AddressRepository _addressRepository;
  final CategoryRepository _categoryRepository;

  Future<void> _onPageStart(
    PageStarted event,
    Emitter<UploadPostState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final fetchedProvinces = await _addressRepository.getProvinces();
      final fetchedHouseTypes = await _categoryRepository.getHouseType();
      emit(
        state.copyWith(
          provincesData: fetchedProvinces,
          houseTypesData: fetchedHouseTypes,
          loadingStatus: LoadingStatus.done,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }
  }

  FutureOr<void> _onTitleChanged(
    TitleChanged event,
    Emitter<UploadPostState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _onDescriptionChanged(
    SummaryDescriptionChanged event,
    Emitter<UploadPostState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<FutureOr<void>> _onProvinceSelected(
    ProvinceSelected event,
    Emitter<UploadPostState> emit,
  ) async {
    // try {
    final provinceId = int.parse(event.province);
    emit(
      state.copyWith(
        selectedProvince: provinceId,
        districtsData: [],
        selectedDistrict: 0,
      ),
    );
    final fetchedDistricts =
        await _addressRepository.getDistrictsByProvinceId(provinceId);
    emit(
      state.copyWith(
        districtsData: fetchedDistricts,
        selectedDistrict: fetchedDistricts.first.id,
      ),
    );
    // } catch (e) {}
  }

  FutureOr<void> _onDistrictSelected(
    DistrictSelected event,
    Emitter<UploadPostState> emit,
  ) {}

  FutureOr<void> _onWardSelected(
    WardSelected event,
    Emitter<UploadPostState> emit,
  ) {}

  FutureOr<void> _onDetailAddressChanged(
    DetailAddressChanged event,
    Emitter<UploadPostState> emit,
  ) {}

  FutureOr<void> _onRoomTypeSelected(
    RoomTypeSelected event,
    Emitter<UploadPostState> emit,
  ) {}

  FutureOr<void> _onRoomPriceChanged(
    RoomPriceChanged event,
    Emitter<UploadPostState> emit,
  ) {}

  FutureOr<void> _onRoomAreaChanged(
    RoomAreaChanged event,
    Emitter<UploadPostState> emit,
  ) {}

  FutureOr<void> _onMaxOfPersonChanged(
    MaxOfPersonChanged event,
    Emitter<UploadPostState> emit,
  ) {}

  FutureOr<void> _onDipositChanged(
    DipositChanged event,
    Emitter<UploadPostState> emit,
  ) {}

  FutureOr<void> _onOtherUtilitiesSelected(
    OtherUtilitiesSelected event,
    Emitter<UploadPostState> emit,
  ) {}

  FutureOr<void> _onRentalObjectsSelected(
    RentalObjectsSelected event,
    Emitter<UploadPostState> emit,
  ) {}

  FutureOr<void> _onNearbyPlacesSelected(
    NearbyPlacesSelected event,
    Emitter<UploadPostState> emit,
  ) {}

  FutureOr<void> _onMediaSelected(
    MediaSelected event,
    Emitter<UploadPostState> emit,
  ) {}

  FutureOr<void> _onUploadPostSubmiited(
    UploadPostSubmiited event,
    Emitter<UploadPostState> emit,
  ) {}
}
