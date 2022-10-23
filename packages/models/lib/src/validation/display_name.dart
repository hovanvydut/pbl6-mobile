import 'package:formz/formz.dart';

enum DislayNameValidationError { empty, tooShort }

class DisplayName extends FormzInput<String, DislayNameValidationError> {
  const DisplayName.pure() : super.pure('');
  const DisplayName.dirty(super.value) : super.dirty();

  @override
  DislayNameValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return value!.length >= 3 ? null : DislayNameValidationError.tooShort;
    } else {
      return DislayNameValidationError.empty;
    }
  }
}
