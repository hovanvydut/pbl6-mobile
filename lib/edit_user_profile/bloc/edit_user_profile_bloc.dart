import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:media/media.dart';
import 'package:models/models.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:user/repositories/user_repository.dart';

part 'edit_user_profile_event.dart';
part 'edit_user_profile_state.dart';

class EditUserProfileBloc
    extends Bloc<EditUserProfileEvent, EditUserProfileState> {
  EditUserProfileBloc({
    required UserRepository userRepository,
    required MediaRepository mediaRepository,
  })  : _userRepository = userRepository,
        _mediaRepository = mediaRepository,
        super(const EditUserProfileState()) {
    on<EditProfilePressed>(_onEditProfilePressed);
    on<ChooseImagePressed>(_onChooseImagePressed);
    on<UseCameraPressed>(_onUseCameraPressed);
    on<RemoveImagePressed>(_onRemoveImagePressed);
    on<DisplayNameChanged>(_onDisplayNameChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<AddressChanged>(_onAddressChanged);
    on<EditSubmitted>(_onSubmitted);
  }

  final UserRepository _userRepository;
  final MediaRepository _mediaRepository;

  void _onEditProfilePressed(
    EditProfilePressed event,
    Emitter<EditUserProfileState> emit,
  ) {
    final displayName = DisplayName.dirty(event.user.displayName);
    final phoneNumber = PhoneNumber.dirty(event.user.phoneNumber!);
    final address = AddressForm.dirty(event.user.address);
    emit(
      state.copyWith(
        editMode: true,
        address: address,
        phoneNumber: phoneNumber,
        displayName: displayName,
      ),
    );
  }

  Future<void> _onChooseImagePressed(
    ChooseImagePressed event,
    Emitter<EditUserProfileState> emit,
  ) async {
    final pickedImage =
        await ImagePickerHelper.pickImageFromSource(ImageSource.gallery);
    emit(state.copyWith(imagePath: pickedImage));
  }

  Future<void> _onUseCameraPressed(
    UseCameraPressed event,
    Emitter<EditUserProfileState> emit,
  ) async {
    final capturedImage =
        await ImagePickerHelper.pickImageFromSource(ImageSource.camera);
    emit(state.copyWith(imagePath: capturedImage));
  }

  FutureOr<void> _onRemoveImagePressed(
    RemoveImagePressed event,
    Emitter<EditUserProfileState> emit,
  ) {
    emit(state.copyWith(imagePath: ''));
  }

  void _onDisplayNameChanged(
    DisplayNameChanged event,
    Emitter<EditUserProfileState> emit,
  ) {
    final displayName = DisplayName.dirty(event.displayName);
    emit(
      state.copyWith(
        displayName: displayName,
        formzStatus: Formz.validate([
          displayName,
          state.phoneNumber,
          state.address,
        ]),
      ),
    );
  }

  void _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<EditUserProfileState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        formzStatus: Formz.validate([
          state.displayName,
          phoneNumber,
          state.address,
        ]),
      ),
    );
  }

  void _onAddressChanged(
    AddressChanged event,
    Emitter<EditUserProfileState> emit,
  ) {
    final address = AddressForm.dirty(event.address);
    emit(
      state.copyWith(
        address: address,
        formzStatus: Formz.validate([
          address,
          state.phoneNumber,
          state.displayName,
        ]),
      ),
    );
  }

  Future<void> _onSubmitted(
    EditSubmitted event,
    Emitter<EditUserProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
      final imageUrl = state.imagePath.isNotNullOrBlank
          ? await _mediaRepository.uploadImage(state.imagePath)
          : null;
      final updatedUser = event.user.copyWith(
        address: state.address.value,
        displayName: state.displayName.value,
        phoneNumber: state.phoneNumber.value,
        avatar: imageUrl,
      );
      await _userRepository.updateUserInformation(updatedUser);
      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      addError(e);
      emit(state.copyWith(formzStatus: FormzStatus.submissionFailure));
      rethrow;
    }
  }
}
