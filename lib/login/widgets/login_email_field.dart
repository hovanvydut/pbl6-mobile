import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/login/login.dart';
import 'package:widgets/widgets.dart';

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final email = context.select((LoginBloc bloc) => bloc.state.email);
        return AppTextField(
          hintText: 'Email của bạn',
          labelText: 'Email',
          errorText: email.invalid ? getErrorText(email.error!) : null,
          onChanged: (value) =>
              context.read<LoginBloc>().add(EmailChanged(email: value)),
          textInputAction: TextInputAction.next,
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
