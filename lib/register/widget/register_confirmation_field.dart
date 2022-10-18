import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/register/register.dart';
import 'package:widgets/widgets.dart';

class RegisterConfirmationPasswordField extends StatelessWidget {
  const RegisterConfirmationPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmationPassword != current.confirmationPassword ||
          previous.isHideConfirmationPassword !=
              current.isHideConfirmationPassword,
      builder: (context, state) {
        return AppTextField(
          obscureText: state.isHideConfirmationPassword,
          hintText: 'Nhập lại mật khẩu của bạn',
          labelText: 'Xác nhận mật khẩu',
          errorText: state.confirmationPassword.invalid
              ? 'Mật khẩu không trùng'
              : null,
          onChanged: (value) => context
              .read<RegisterBloc>()
              .add(ConfirmationPasswordChanged(confirmationPassword: value)),
          suffixIcon: IconButton(
            icon: state.isHideConfirmationPassword
                ? Assets.icons.eyeShow
                    .svg(color: theme.colorScheme.onSurfaceVariant)
                : Assets.icons.eyeHide
                    .svg(color: theme.colorScheme.onSurfaceVariant),
            onPressed: () => context
                .read<RegisterBloc>()
                .add(ShowHideConfirmationPasswordPressed()),
          ),
          isFinalFieldInForm: true,
        );
      },
    );
  }
}
