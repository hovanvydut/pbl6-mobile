import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/register/bloc/register_bloc.dart';
import 'package:widgets/widgets.dart';

class RegisterPasswordField extends StatelessWidget {
  const RegisterPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final password =
            context.select((RegisterBloc bloc) => bloc.state.password);
        final isHidePassword =
            context.select((RegisterBloc bloc) => bloc.state.isHidePassword);
        return AppTextField(
          obscureText: isHidePassword,
          hintText: 'Mật khẩu của bạn',
          labelText: 'Mật khẩu',
          errorText: password.invalid ? getErrorText(password.error!) : null,
          onChanged: (value) => context
              .read<RegisterBloc>()
              .add(PasswordChanged(password: value)),
          suffixIcon: IconButton(
            icon: isHidePassword
                ? Assets.icons.eyeShow.svg()
                : Assets.icons.eyeHide.svg(),
            onPressed: () =>
                context.read<RegisterBloc>().add(ShowHidePasswordPressed()),
          ),
          textInputAction: TextInputAction.next,
        );
      },
    );
  }

  String getErrorText(PasswordValidationError error) {
    switch (error) {
      case PasswordValidationError.empty:
        return 'Mật khẩu không được để trống';
      case PasswordValidationError.tooShort:
        return 'Mật khẩu phải từ 8 ký tự trở lên';
    }
  }
}
