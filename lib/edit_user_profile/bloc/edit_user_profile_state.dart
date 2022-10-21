part of 'edit_user_profile_bloc.dart';

 class EditUserProfileState extends Equatable {
  const EditUserProfileState({  this.editMode = false,
  });

  final bool editMode;

  @override
  List<Object?> get props => [editMode];

  EditUserProfileState copyWith({
    bool? editMode,
  }) {
    return EditUserProfileState(
      editMode: editMode ?? this.editMode,
    );
  }
}

