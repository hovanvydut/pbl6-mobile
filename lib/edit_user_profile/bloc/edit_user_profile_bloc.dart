import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_helper/platform_helper.dart';

part 'edit_user_profile_event.dart';
part 'edit_user_profile_state.dart';

class EditUserProfileBloc
    extends Bloc<EditUserProfileEvent, EditUserProfileState> {
  EditUserProfileBloc() : super(const EditUserProfileState()) {
    on<EditProfilePressed>(_onEditProfilePressed);
    on<ChooseImagePressed>(_onChooseImagePressed);
    on<UseCameraPressed>(_onUseCameraPressed);
  }

  void _onEditProfilePressed(
    EditProfilePressed event,
    Emitter<EditUserProfileState> emit,
  ) {
    emit(state.copyWith(editMode: true));
  }

  void _onChooseImagePressed(
    ChooseImagePressed event,
    Emitter<EditUserProfileState> emit,
  ) {}

  Future<FutureOr<void>> _onUseCameraPressed(
    UseCameraPressed event,
    Emitter<EditUserProfileState> emit,
  ) async {
    final capturedImage =
        await ImagePickerHelper.pickImageFromSource(ImageSource.camera);
  }
}
