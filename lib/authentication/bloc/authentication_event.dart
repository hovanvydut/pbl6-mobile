part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class GetUserInformation extends AuthenticationEvent {}

class LogoutRequested extends AuthenticationEvent {}
