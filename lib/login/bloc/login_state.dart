part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isHidePassword = true,
    this.formStatus = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final bool isHidePassword;
  final FormzStatus formStatus;

  @override
  List<Object?> get props => [
        email,
        password,
        isHidePassword,
        formStatus,
      ];

  LoginState copyWith({
    Email? email,
    Password? password,
    bool? isHidePassword,
    FormzStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isHidePassword: isHidePassword ?? this.isHidePassword,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
