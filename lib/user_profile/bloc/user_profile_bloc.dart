import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(const UserProfileState()) {
    on<EditProfilePressed>(_onEditProfilePressed);
    on<SwitchToHomePressed>(_onSwitchToHomePressed);
  }

  void _onEditProfilePressed(
    EditProfilePressed event,
    Emitter<UserProfileState> emit,
  ) {
    emit(state.copyWith(editMode: true));
  }

  void _onSwitchToHomePressed(
    SwitchToHomePressed event,
    Emitter<UserProfileState> emit,
  ) {
    emit(state.copyWith(isInHostPanel: !state.isInHostPanel));
  }
}
