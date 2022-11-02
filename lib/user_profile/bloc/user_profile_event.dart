part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object?> get props => [];
}

class EditProfilePressed extends UserProfileEvent {}

class SwitchToHomePressed extends UserProfileEvent {}

class ChooseImagePressed extends UserProfileEvent {}
