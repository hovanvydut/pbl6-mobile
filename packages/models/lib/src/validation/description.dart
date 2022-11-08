import 'package:formz/formz.dart';

enum DescriptionValidationError { empty }

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.pure() : super.pure('');
  const Description.dirty(super.value) : super.dirty();

  @override
  DescriptionValidationError? validator(String? value) {
    if (value?.isEmpty == true) {
      return DescriptionValidationError.empty;
    }
    return null;
  }
}
