part of 'edit_user_profile_bloc.dart';

abstract class EditUserProfileEvent extends Equatable {
  const EditUserProfileEvent();

  @override
  List<Object?> get props => [];
}

class EditProfilePressed extends EditUserProfileEvent {
  const EditProfilePressed(this.user);
  final User user;

  @override
  List<Object?> get props => [user];
}

class ChooseImagePressed extends EditUserProfileEvent {}

class UseCameraPressed extends EditUserProfileEvent {}

class RemoveImagePressed extends EditUserProfileEvent {}

class DisplayNameChanged extends EditUserProfileEvent {
  const DisplayNameChanged(this.displayName);
  final String displayName;

  @override
  List<Object?> get props => [displayName];
}

class PhoneNumberChanged extends EditUserProfileEvent {
  const PhoneNumberChanged(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}

class AddressChanged extends EditUserProfileEvent {
  const AddressChanged(this.address);
  final String address;

  @override
  List<Object?> get props => [address];
}

class EditSubmitted extends EditUserProfileEvent {
  const EditSubmitted(this.user);
  final User user;

  @override
  List<Object?> get props => [user];
}
