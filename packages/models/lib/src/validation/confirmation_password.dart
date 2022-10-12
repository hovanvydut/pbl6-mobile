import 'package:formz/formz.dart';

enum ConfirmationPasswordValidationError { notMatch }

class ConfirmationPassword
    extends FormzInput<String, ConfirmationPasswordValidationError> {
  const ConfirmationPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmationPassword.dirty({
    this.password = '',
    String value = '',
  }) : super.dirty(value);

  final String password;
  @override
  ConfirmationPasswordValidationError? validator(String? value) {
    return password == value
        ? null
        : ConfirmationPasswordValidationError.notMatch;
  }
}
