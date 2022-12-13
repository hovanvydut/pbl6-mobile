import 'package:formz/formz.dart';

enum NumbericFieldValidationError { empty, nan }

class NumbericField extends FormzInput<num?, NumbericFieldValidationError> {
  const NumbericField.pure() : super.pure(0);
  const NumbericField.dirty(super.value) : super.dirty();

  @override
  NumbericFieldValidationError? validator(num? value) {
    if (value == null) {
      return NumbericFieldValidationError.empty;
    }
    if (value.isNaN) {
      return NumbericFieldValidationError.nan;
    }
    return null;
  }
}
