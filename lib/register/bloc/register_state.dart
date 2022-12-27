part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.displayName = const DisplayName.pure(),
    this.confirmationPassword = const ConfirmationPassword.pure(),
    this.isHidePassword = true,
    this.isHideConfirmationPassword = true,
    this.formStatus = FormzStatus.pure,
    this.selectedRole,
  });

  final Email email;
  final Password password;
  final DisplayName displayName;
  final ConfirmationPassword confirmationPassword;
  final bool isHidePassword;
  final bool isHideConfirmationPassword;
  final FormzStatus formStatus;
  final Role? selectedRole;

  @override
  List<Object?> get props => [
        email,
        password,
        displayName,
        confirmationPassword,
        isHidePassword,
        isHideConfirmationPassword,
        formStatus,
        selectedRole
      ];

  RegisterState copyWith({
    Email? email,
    Password? password,
    DisplayName? displayName,
    ConfirmationPassword? confirmationPassword,
    bool? isHidePassword,
    bool? isHideConfirmationPassword,
    FormzStatus? formStatus,
    Role? selectedRole,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      confirmationPassword: confirmationPassword ?? this.confirmationPassword,
      isHidePassword: isHidePassword ?? this.isHidePassword,
      isHideConfirmationPassword:
          isHideConfirmationPassword ?? this.isHideConfirmationPassword,
      formStatus: formStatus ?? this.formStatus,
      selectedRole: selectedRole ?? this.selectedRole,
    );
  }
}
