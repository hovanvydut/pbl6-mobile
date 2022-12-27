import 'dart:async';

import 'package:auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:permissions/permissions.dart';
import 'package:user/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required UserRepository userRepository,
    required AuthRepository authRepository,
    required PermissionsRepository permissionsRepository,
  })  : _userRepository = userRepository,
        _authRepository = authRepository,
        _permissionsRepository = permissionsRepository,
        super(const Unknown()) {
    on<GetUserInformation>(_onGetUserInformation);
    on<LogoutRequested>(_onLogoutRequested);
    add(GetUserInformation());
  }

  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final PermissionsRepository _permissionsRepository;

  Future<void> _onGetUserInformation(
    GetUserInformation event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final user = await _userRepository.getUserInformation();
      if (user == null) {
        emit(const Unknown());
        return;
      }
      final permissions = await _permissionsRepository.getUserPermissions();
      emit(Authenticated(user: user, permissions: permissions));
    } on UnauthorizedException {
      emit(const EndSession());
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const Unauthenticated());
    await _authRepository.removeToken();
  }
}
