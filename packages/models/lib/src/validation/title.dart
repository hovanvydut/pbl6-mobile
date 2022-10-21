import 'package:formz/formz.dart';

enum TitleValidationError { empty, tooShort }

class Title extends FormzInput<String, TitleValidationError> {
  const Title.pure() : super.pure('');
  const Title.dirty(super.value) : super.dirty();

  @override
  TitleValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return value!.length >= 8 ? null : TitleValidationError.tooShort;
    } else {
      return TitleValidationError.empty;
    }
  }
}
