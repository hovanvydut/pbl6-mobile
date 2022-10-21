import 'package:formz/formz.dart';

enum DescriptionValidationError { empty, tooShort }

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.pure() : super.pure('');
  const Description.dirty(super.value) : super.dirty();

  @override
  DescriptionValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return value!.length >= 8 ? null : DescriptionValidationError.tooShort;
    } else {
      return DescriptionValidationError.empty;
    }
  }
}
