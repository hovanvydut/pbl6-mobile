import 'package:formz/formz.dart';

enum LimitLengthFieldValidationError { empty, tooShort }

class LimitLengthField
    extends FormzInput<String, LimitLengthFieldValidationError> {
  const LimitLengthField.pure(this.limitLength) : super.pure('');
  const LimitLengthField.dirty(super.value, {required this.limitLength})
      : super.dirty();

  final int limitLength;

  @override
  LimitLengthFieldValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return value!.length >= limitLength
          ? null
          : LimitLengthFieldValidationError.tooShort;
    } else {
      return LimitLengthFieldValidationError.empty;
    }
  }
}
