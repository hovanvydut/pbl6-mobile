part of 'user_profile_bloc.dart';

class UserProfileState extends Equatable {
  const UserProfileState({
    this.editMode = false,
    this.isInHostPanel = false, 
  });

  final bool editMode;
  final bool isInHostPanel;

  @override
  List<Object?> get props => [editMode, isInHostPanel];

  UserProfileState copyWith({
    bool? editMode,
    bool? isInHostPanel,
  }) {
    return UserProfileState(
      editMode: editMode ?? this.editMode,
      isInHostPanel: isInHostPanel ?? this.isInHostPanel,
    );
  }
}
