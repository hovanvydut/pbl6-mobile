part of 'user_profile_bloc.dart';

class UserProfileState extends Equatable {
  const UserProfileState({
    this.editMode = false,
  });

  final bool editMode;

  @override
  List<Object?> get props => [editMode];

  UserProfileState copyWith({
    bool? editMode,
  }) {
    return UserProfileState(
      editMode: editMode ?? this.editMode,
    );
  }
}
