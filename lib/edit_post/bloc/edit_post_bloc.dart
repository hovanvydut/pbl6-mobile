import 'dart:async';
import 'dart:developer';

import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media/media.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:post/post.dart';
import 'package:property/property.dart';

part 'edit_post_event.dart';
part 'edit_post_state.dart';

class EditPostBloc extends Bloc<EditPostEvent, EditPostState> {
  EditPostBloc({
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
        super(const EditPostState()) {
    on<EditPageStarted>(_onPageStart);
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
    on<MediaRemovePressed>(_onMediaRemovePressed);
    on<EditPostSubmitted>(_onEditPostSubmitted);
  }

  final AddressRepository _addressRepository;
  final CategoryRepository _categoryRepository;
  final PropertyRepository _propertyRepository;
  final PostRepository _postRepository;
  final MediaRepository _mediaRepository;

  Future<void> _onPageStart(
    EditPageStarted event,
    Emitter<EditPostState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final fetchedProvinces = await _addressRepository.getProvinces();
      final fetchedHouseTypes = await _categoryRepository.getHouseTypes();
      final fetchedProperties = await _propertyRepository.getGroupProperties();
      final post = event.post;
      emit(
        state.copyWith(
          provincesData: fetchedProvinces,
          houseTypesData: fetchedHouseTypes,
          otherUtilsData: fetchedProperties[PropertyType.util]!.properties,
          rentalObjectsData: fetchedProperties[PropertyType.rental]!.properties,
          nearbyPlacesData: fetchedProperties[PropertyType.nearby]!.properties,
          loadingStatus: LoadingStatus.done,
          medias: post.medias.map((media) => media.url).toList(),
        ),
      );
      add(ProvinceSelected(post.fullAddress.province.id.toString()));
      add(DistrictSelected(post.fullAddress.district.id.toString()));
      add(WardSelected(post.fullAddress.ward.id.toString()));
      add(HouseTypeSelected(post.category.id.toString()));
      final nearbyPlaces = post.properties
          ?.where((property) => property.groupPropertyId == 1)
          .map((property) => property.displayName)
          .toList();
      final otherUtils = post.properties
          ?.where((property) => property.groupPropertyId == 2)
          .map((property) => property.displayName)
          .toList();
      final rentalObjects = post.properties
          ?.where((property) => property.groupPropertyId == 3)
          .map((property) => property.displayName)
          .toList();

      add(RentalObjectsSelected(rentalObjects ?? []));
      add(OtherUtilitiesSelected(otherUtils ?? []));
      add(NearbyPlacesSelected(nearbyPlaces ?? []));
      add(TitleChanged(post.title));
      add(SummaryDescriptionChanged(post.description!));
      add(RoomAreaChanged(post.area.toString()));
      add(RoomPriceChanged(post.price));
      add(DipositChanged(post.prePaidPrice ?? 0));
      add(MaxOfPersonChanged(post.limitTenant.toString()));
      add(DetailAddressChanged(post.address));
      add(HouseTypeSelected(post.category.id.toString()));
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }
  }

  void _onTitleChanged(
    TitleChanged event,
    Emitter<EditPostState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
    SummaryDescriptionChanged event,
    Emitter<EditPostState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onProvinceSelected(
    ProvinceSelected event,
    Emitter<EditPostState> emit,
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
    Emitter<EditPostState> emit,
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
    Emitter<EditPostState> emit,
  ) {
    final wardId = int.parse(event.ward);
    emit(state.copyWith(selectedWard: wardId));
  }

  void _onDetailAddressChanged(
    DetailAddressChanged event,
    Emitter<EditPostState> emit,
  ) {
    emit(state.copyWith(detailAddress: event.address));
  }

  void _onHouseTypeSelected(
    HouseTypeSelected event,
    Emitter<EditPostState> emit,
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
    Emitter<EditPostState> emit,
  ) {
    final price = event.price.toDouble();
    emit(state.copyWith(price: price));
  }

  void _onRoomAreaChanged(
    RoomAreaChanged event,
    Emitter<EditPostState> emit,
  ) {
    final area = double.parse(event.area);
    emit(state.copyWith(area: area));
  }

  void _onMaxOfPersonChanged(
    MaxOfPersonChanged event,
    Emitter<EditPostState> emit,
  ) {
    final maxOfPerson = int.parse(event.maxOfPerson);
    emit(state.copyWith(maxOfPerson: maxOfPerson));
  }

  void _onDipositChanged(
    DipositChanged event,
    Emitter<EditPostState> emit,
  ) {
    final diposit = event.diposit.toDouble();
    emit(state.copyWith(diposit: diposit));
  }

  void _onOtherUtilitiesSelected(
    OtherUtilitiesSelected event,
    Emitter<EditPostState> emit,
  ) {
    emit(
      state.copyWith(
        selectedOtherUtils: List.from(event.utilities),
      ),
    );
  }

  void _onRentalObjectsSelected(
    RentalObjectsSelected event,
    Emitter<EditPostState> emit,
  ) {
    emit(
      state.copyWith(
        selectedRentailObjects: List.from(event.rentailObjects),
      ),
    );
  }

  void _onNearbyPlacesSelected(
    NearbyPlacesSelected event,
    Emitter<EditPostState> emit,
  ) {
    emit(
      state.copyWith(
        selectedNearbyPlaces: List.from(event.nearbyPlaces),
      ),
    );
  }

  Future<void> _onMediaSelected(
    MediaSelected event,
    Emitter<EditPostState> emit,
  ) async {
    final imagePath =
        await ImagePickerHelper.pickImageFromSource(ImageSource.gallery);
    if (imagePath != null) {
      emit(state.copyWith(medias: [...state.medias, imagePath]));
    }
  }

  Future<void> _onEditPostSubmitted(
    EditPostSubmitted event,
    Emitter<EditPostState> emit,
  ) async {
    try {
      emit(state.copyWith(editPostStatus: LoadingStatus.loading));
      final title = state.title;
      final description = state.description;
      final address = state.detailAddress;
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
        var url = mediaPath;
        if (!url.startsWith('http://') && !url.startsWith('https://')) {
          log('hehe');
          url = await _mediaRepository.uploadImage(mediaPath);
        }
        mediaUrls.add(url);
      }
      await _postRepository.updatePostByPostId(
        event.post.id,
        address: address,
        area: area,
        description: description,
        houseTypeId: houseTypeId,
        limitTenant: limitedTenant,
        prePaidPrice: prePaid,
        price: price,
        properties: propertiesId,
        title: title,
        wardId: wardId,
        medias: mediaUrls
            .map((url) => Media(contentType: 'image', url: url))
            .toList(),
      );
      emit(state.copyWith(editPostStatus: LoadingStatus.done));
    } catch (e) {
      emit(state.copyWith(editPostStatus: LoadingStatus.error));
      rethrow;
    }
  }

  void _onMediaRemovePressed(
    MediaRemovePressed event,
    Emitter<EditPostState> emit,
  ) {
    emit(
      state.copyWith(
        medias: state.medias.where((media) => media != event.media).toList(),
      ),
    );
  }
}
