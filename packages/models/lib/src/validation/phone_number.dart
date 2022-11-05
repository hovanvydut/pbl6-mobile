import 'package:formz/formz.dart';

enum PhoneNumberValidationError { empty, notValid }

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty(super.value) : super.dirty();

  @override
  PhoneNumberValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneNumberValidationError.empty;
    }
    if (!RegExp('(84|0[3|5|7|8|9])+([0-9]{8})').hasMatch(value)) {
      return PhoneNumberValidationError.notValid;
    }
    return null;
  }
}
