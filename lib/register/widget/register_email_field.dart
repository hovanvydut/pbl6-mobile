import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:widgets/widgets.dart';

class RegisterEmailField extends StatelessWidget {
  const RegisterEmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // final email = context.select((LoginBloc bloc) => bloc.state.email);
        return AppTextField(
          hintText: 'Email của bạn',
          labelText: 'Email',
          // errorText: email.invalid ? getErrorText(email.error!) : null,
          onChanged: (value) {},
          // context.read<LoginBloc>().add(EmailChanged(email: value)),
        );
      },
    );
  }

  String getErrorText(EmailValidationError error) {
    switch (error) {
      case EmailValidationError.empty:
        return 'Email không được để trống';
      case EmailValidationError.notValid:
        return 'Email không đúng định dạng';
    }
  }
}
