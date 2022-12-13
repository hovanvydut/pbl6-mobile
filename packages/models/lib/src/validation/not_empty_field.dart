import 'package:formz/formz.dart';

enum NotEmptyFieldValidationError { empty }

class NotEmptyField extends FormzInput<String, NotEmptyFieldValidationError> {
  const NotEmptyField.pure() : super.pure('');
  const NotEmptyField.dirty(super.value) : super.dirty();

  @override
  NotEmptyFieldValidationError? validator(String? value) {
    if (value?.isEmpty == true) {
      return NotEmptyFieldValidationError.empty;
    }
    return null;
  }
}
