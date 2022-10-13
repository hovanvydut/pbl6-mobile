import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/login/login.dart';
import 'package:widgets/widgets.dart';

class RegisterPasswordField extends StatelessWidget {
  const RegisterPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // final password =
        //     context.select((LoginBloc bloc) => bloc.state.password);
        // final isHidePassword =
        //     context.select((LoginBloc bloc) => bloc.state.isHidePassword);
        return AppTextField(
          obscureText: true,
          hintText: 'Mật khẩu của bạn',
          labelText: 'Mật khẩu',
          // errorText: password.invalid ? getErrorText(password.error!) : null,
          onChanged: (value) =>
              context.read<LoginBloc>().add(PasswordChanged(password: value)),
          suffixIcon: IconButton(
            icon: true
                ? Assets.icons.eyeShow.svg()
                : Assets.icons.eyeHide.svg(),
            onPressed: () =>
                context.read<LoginBloc>().add(ShowHidePasswordPressed()),
          ),
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
