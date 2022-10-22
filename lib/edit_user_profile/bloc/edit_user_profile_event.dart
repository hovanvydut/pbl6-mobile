part of 'edit_user_profile_bloc.dart';

abstract class EditUserProfileEvent extends Equatable {
  const EditUserProfileEvent();

  @override
  List<Object?> get props => [];
}

class EditProfilePressed extends EditUserProfileEvent {}

class ChooseImagePressed extends EditUserProfileEvent {}

class UseCameraPressed extends EditUserProfileEvent {}
