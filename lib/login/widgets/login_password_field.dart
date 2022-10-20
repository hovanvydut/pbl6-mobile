import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/login/login.dart';
import 'package:widgets/widgets.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Builder(
      builder: (context) {
        final password =
            context.select((LoginBloc bloc) => bloc.state.password);
        final isHidePassword =
            context.select((LoginBloc bloc) => bloc.state.isHidePassword);
        return AppTextField(
          obscureText: isHidePassword,
          hintText: 'Mật khẩu của bạn',
          labelText: 'Mật khẩu',
          errorText: password.invalid ? getErrorText(password.error!) : null,
          onChanged: (value) =>
              context.read<LoginBloc>().add(PasswordChanged(password: value)),
          suffixIcon: IconButton(
            icon: isHidePassword
                ? Assets.icons.eyeShow
                    .svg(color: theme.colorScheme.onSurfaceVariant)
                : Assets.icons.eyeHide
                    .svg(color: theme.colorScheme.onSurfaceVariant),
            onPressed: () =>
                context.read<LoginBloc>().add(ShowHidePasswordPressed()),
          ),
          lastField: true,
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
