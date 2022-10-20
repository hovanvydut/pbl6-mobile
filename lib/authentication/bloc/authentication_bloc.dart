import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:user/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const Unknown()) {
    on<GetUserInformation>(_onGetUserInformation);
    on<LogoutRequested>(_onLogoutRequested);
    add(GetUserInformation());
  }

  final UserRepository _userRepository;

  Future<void> _onGetUserInformation(
    GetUserInformation event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final user = await _userRepository.getUserInformation();
      if (user == null) {
        emit(const Unauthenticated());
        return;
      }
      emit(Authenticated(user: user));
    } catch (e) {
      addError(e);
      emit(const Unauthenticated());
    }
  }

  void _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(const Unauthenticated());
  }
}
