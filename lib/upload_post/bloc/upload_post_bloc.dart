import 'dart:async';

import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:media/repositories/media_repository.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:post/post.dart';
import 'package:property/property.dart';

part 'upload_post_event.dart';
part 'upload_post_state.dart';

class UploadUserPostBloc extends Bloc<UploadPostEvent, UploadUserPostState> {
  UploadUserPostBloc({
    required AddressRepository addressRepository,
    required CategoryRepository categoryRepository,
    required PropertyRepository propertyRepository,
    required PostRepository postRepository,
    required MediaRepository mediaRepository,
  })  : _addressRepository = addressRepository,
        _categoryRepository = categoryRepository,
        _propertyRepository = propertyRepository,
        _postRepository = postRepository,
        _mediaRepository = mediaRepository,
        super(const UploadUserPostState()) {
    on<PageStarted>(_onPageStart);
    on<TitleChanged>(_onTitleChanged);
    on<SummaryDescriptionChanged>(_onDescriptionChanged);
    on<ProvinceSelected>(_onProvinceSelected);
    on<DistrictSelected>(_onDistrictSelected);
    on<WardSelected>(_onWardSelected);
    on<DetailAddressChanged>(_onDetailAddressChanged);
    on<HouseTypeSelected>(_onHouseTypeSelected);
    on<RoomPriceChanged>(_onRoomPriceChanged);
    on<RoomAreaChanged>(_onRoomAreaChanged);
    on<MaxOfPersonChanged>(_onMaxOfPersonChanged);
    on<DipositChanged>(_onDipositChanged);
    on<OtherUtilitiesSelected>(_onOtherUtilitiesSelected);
    on<RentalObjectsSelected>(_onRentalObjectsSelected);
    on<NearbyPlacesSelected>(_onNearbyPlacesSelected);
    on<MediaSelected>(_onMediaSelected);
    on<UploadPostSubmiited>(_onUploadPostSubmiited);
    on<MediaRemovePressed>(_onMediaRemovePressed);

    add(PageStarted());
  }

  final AddressRepository _addressRepository;
  final CategoryRepository _categoryRepository;
  final PropertyRepository _propertyRepository;
  final PostRepository _postRepository;
  final MediaRepository _mediaRepository;

  Future<void> _onPageStart(
    PageStarted event,
    Emitter<UploadUserPostState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final fetchedProvinces = await _addressRepository.getProvinces();
      final fetchedHouseTypes = await _categoryRepository.getHouseTypes();
      final fetchedProperties = await _propertyRepository.getGroupProperties();
      emit(
        state.copyWith(
          provincesData: fetchedProvinces,
          houseTypesData: fetchedHouseTypes,
          otherUtilsData: fetchedProperties[PropertyType.util]!.properties,
          rentalObjectsData: fetchedProperties[PropertyType.rental]!.properties,
          nearbyPlacesData: fetchedProperties[PropertyType.nearby]!.properties,
          loadingStatus: LoadingStatus.done,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }
  }

  void _onTitleChanged(
    TitleChanged event,
    Emitter<UploadUserPostState> emit,
  ) {
    final title = LimitLengthField.dirty(event.title, limitLength: 8);
    emit(
      state.copyWith(
        title: title,
        formValidationStatus: Formz.validate([
          title,
          state.description,
          state.detailAddress,
        ]),
      ),
    );
  }

  void _onDescriptionChanged(
    SummaryDescriptionChanged event,
    Emitter<UploadUserPostState> emit,
  ) {
    final description = NotEmptyField.dirty(event.description);
    emit(
      state.copyWith(
        description: description,
        formValidationStatus: Formz.validate([
          state.title,
          description,
          state.detailAddress,
        ]),
      ),
    );
  }

  Future<void> _onProvinceSelected(
    ProvinceSelected event,
    Emitter<UploadUserPostState> emit,
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

  Future<void> _onDistrictSelected(
    DistrictSelected event,
    Emitter<UploadUserPostState> emit,
  ) async {
    // try {
    final districtId = int.parse(event.district);
    emit(state.copyWith(selectedDistrict: districtId));
    final fetchedWards =
        await _addressRepository.getWardsByDistrictId(districtId);
    emit(
      state.copyWith(
        selectedWard: fetchedWards.first.id,
        wardsData: fetchedWards,
      ),
    );
  }

  void _onWardSelected(
    WardSelected event,
    Emitter<UploadUserPostState> emit,
  ) {
    final wardId = int.parse(event.ward);
    emit(state.copyWith(selectedWard: wardId));
  }

  void _onDetailAddressChanged(
    DetailAddressChanged event,
    Emitter<UploadUserPostState> emit,
  ) {
    final detailAddress = NotEmptyField.dirty(event.address);
    emit(
      state.copyWith(
        detailAddress: detailAddress,
        formValidationStatus: Formz.validate([
          detailAddress,
          state.description,
          state.title,
        ]),
      ),
    );
  }

  void _onHouseTypeSelected(
    HouseTypeSelected event,
    Emitter<UploadUserPostState> emit,
  ) {
    final houseTypeId = int.parse(event.houseType);
    emit(
      state.copyWith(
        selectedHouseType: houseTypeId,
      ),
    );
  }

  void _onRoomPriceChanged(
    RoomPriceChanged event,
    Emitter<UploadUserPostState> emit,
  ) {
    final price = NumbericField.dirty(event.price);
    emit(state.copyWith(price: price));
  }

  void _onRoomAreaChanged(
    RoomAreaChanged event,
    Emitter<UploadUserPostState> emit,
  ) {
    final area = NumbericField.dirty(num.tryParse(event.area));
    emit(state.copyWith(area: area));
  }

  void _onMaxOfPersonChanged(
    MaxOfPersonChanged event,
    Emitter<UploadUserPostState> emit,
  ) {
    final maxOfPerson = NumbericField.dirty(num.tryParse(event.maxOfPerson));
    emit(state.copyWith(maxOfPerson: maxOfPerson));
  }

  void _onDipositChanged(
    DipositChanged event,
    Emitter<UploadUserPostState> emit,
  ) {
    final diposit = NumbericField.dirty(event.diposit);
    emit(state.copyWith(diposit: diposit));
  }

  void _onOtherUtilitiesSelected(
    OtherUtilitiesSelected event,
    Emitter<UploadUserPostState> emit,
  ) {
    emit(
      state.copyWith(
        selectedOtherUtils: List.from(event.utilities),
      ),
    );
  }

  void _onRentalObjectsSelected(
    RentalObjectsSelected event,
    Emitter<UploadUserPostState> emit,
  ) {
    emit(
      state.copyWith(
        selectedRentailObjects: List.from(event.rentailObjects),
      ),
    );
  }

  void _onNearbyPlacesSelected(
    NearbyPlacesSelected event,
    Emitter<UploadUserPostState> emit,
  ) {
    emit(
      state.copyWith(
        selectedNearbyPlaces: List.from(event.nearbyPlaces),
      ),
    );
  }

  Future<void> _onMediaSelected(
    MediaSelected event,
    Emitter<UploadUserPostState> emit,
  ) async {
    final imagePath =
        await ImagePickerHelper.pickImageFromSource(ImageSource.gallery);
    if (imagePath != null) {
      emit(state.copyWith(medias: [...state.medias, imagePath]));
    }
  }

  Future<void> _onUploadPostSubmiited(
    UploadPostSubmiited event,
    Emitter<UploadUserPostState> emit,
  ) async {
    try {
      emit(state.copyWith(uploadPostStatus: LoadingStatus.loading));
      final title = state.title.value;
      final description = state.description.value;
      final address = state.detailAddress.value;
      final wardId = state.selectedWard;
      final limitedTenant = state.maxOfPerson;
      final houseTypeId = state.selectedHouseType;
      final price = state.price;
      final prePaid = state.diposit;
      final area = state.area;
      final propertiesId = <int>[];
      final mediaUrls = <String>[];
      for (final object in state.selectedRentailObjects) {
        final rentalObject = state.rentalObjectsData.firstWhere(
          (element) => element.displayName.compareTo(object) == 0,
        );
        propertiesId.add(rentalObject.id);
      }
      for (final place in state.selectedNearbyPlaces) {
        final nearbyPlace = state.nearbyPlacesData
            .firstWhere((element) => element.displayName.compareTo(place) == 0);
        propertiesId.add(nearbyPlace.id);
      }
      for (final util in state.selectedOtherUtils) {
        final otherUtil = state.otherUtilsData
            .firstWhere((element) => element.displayName == util);
        propertiesId.add(otherUtil.id);
      }
      for (final mediaPath in state.medias) {
        final url = await compute(_mediaRepository.uploadImage, mediaPath);
        mediaUrls.add(url);
      }
      await _postRepository.createPost(
        address: address,
        area: area.value!.toDouble(),
        description: description,
        houseTypeId: houseTypeId,
        limitTenant: limitedTenant.value!.toInt(),
        prePaidPrice: prePaid.value!.toDouble(),
        price: price.value!.toDouble(),
        properties: propertiesId,
        title: title,
        wardId: wardId,
        medias: mediaUrls
            .map((e) => Media(contentType: 'image/png', url: e))
            .toList(),
      );
      emit(state.copyWith(uploadPostStatus: LoadingStatus.done));
    } catch (e, ee) {
      addError(e, ee);
      emit(state.copyWith(uploadPostStatus: LoadingStatus.error));
      rethrow;
    }
  }

  void _onMediaRemovePressed(
    MediaRemovePressed event,
    Emitter<UploadUserPostState> emit,
  ) {
    emit(
      state.copyWith(
        medias:
            state.medias.where((media) => media != event.imagePath).toList(),
      ),
    );
  }
}
