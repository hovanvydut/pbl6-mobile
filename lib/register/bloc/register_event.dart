part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends RegisterEvent {
  const EmailChanged({
    required this.email,
  });
  final String email;

  @override
  List<Object?> get props => [email];
}

class DisplayNameChanged extends RegisterEvent {
  const DisplayNameChanged({
    required this.displayName,
  });
  final String displayName;

  @override
  List<Object?> get props => [displayName];
}

class PasswordChanged extends RegisterEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

class ConfirmationPasswordChanged extends RegisterEvent {
  const ConfirmationPasswordChanged({required this.confirmationPassword});

  final String confirmationPassword;

  @override
  List<Object?> get props => [confirmationPassword];
}

class RolePressed extends RegisterEvent {
  const RolePressed({required this.role});
  final Role role;

  @override
  List<Object?> get props => [role];
}

class ShowHidePasswordPressed extends RegisterEvent {}

class ShowHideConfirmationPasswordPressed extends RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {}
