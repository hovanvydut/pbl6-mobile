import 'package:formz/formz.dart';

enum AddressValidationError { empty, tooShort }

class AddressForm extends FormzInput<String, AddressValidationError> {
  const AddressForm.pure() : super.pure('');
  const AddressForm.dirty(super.value) : super.dirty();

  @override
  AddressValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return value!.length >= 8 ? null : AddressValidationError.tooShort;
    } else {
      return AddressValidationError.empty;
    }
  }
}
