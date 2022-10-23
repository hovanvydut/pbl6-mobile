part of 'edit_user_profile_bloc.dart';

class EditUserProfileState extends Equatable {
  const EditUserProfileState({
    this.editMode = false,
    this.imagePath = '',
    this.phoneNumber = const PhoneNumber.pure(),
    this.address = const AddressForm.pure(),
    this.displayName = const DisplayName.pure(),
    this.wardId = 0,
    this.formzStatus = FormzStatus.pure,
  });

  final bool editMode;
  final String imagePath;
  final PhoneNumber phoneNumber;
  final AddressForm address;
  final DisplayName displayName;
  final int wardId;
  final FormzStatus formzStatus;

  @override
  List<Object?> get props => [
        editMode,
        imagePath,
        phoneNumber,
        address,
        displayName,
        wardId,
        formzStatus,
      ];

  EditUserProfileState copyWith({
    bool? editMode,
    String? imagePath,
    PhoneNumber? phoneNumber,
    AddressForm? address,
    DisplayName? displayName,
    int? wardId,
    FormzStatus? formzStatus,
  }) {
    return EditUserProfileState(
      editMode: editMode ?? this.editMode,
      imagePath: imagePath ?? this.imagePath,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      displayName: displayName ?? this.displayName,
      wardId: wardId ?? this.wardId,
      formzStatus: formzStatus ?? this.formzStatus,
    );
  }
}
