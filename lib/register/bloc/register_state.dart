part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmationPassword = const ConfirmationPassword.pure(),
    this.isHidePassword = true,
    this.isHideConfirmationPassword = true,
    this.formStatus = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final ConfirmationPassword confirmationPassword;
  final bool isHidePassword;
  final bool isHideConfirmationPassword;
  final FormzStatus formStatus;

  @override
  List<Object?> get props => [
        email,
        password,
        confirmationPassword,
        isHidePassword,
        isHideConfirmationPassword,
        formStatus,
      ];

  RegisterState copyWith({
    Email? email,
    Password? password,
    ConfirmationPassword? confirmationPassword,
    bool? isHidePassword,
    bool? isHideConfirmationPassword,
    FormzStatus? formStatus,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmationPassword: confirmationPassword ?? this.confirmationPassword,
      isHidePassword: isHidePassword ?? this.isHidePassword,
      isHideConfirmationPassword:
          isHideConfirmationPassword ?? this.isHideConfirmationPassword,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
