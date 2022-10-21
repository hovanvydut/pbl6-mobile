import 'package:auth/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/login/login.dart';
import 'package:widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    required this.onToRegisterPressed,
    required this.onAfterLoginChanged,
  });

  final void Function() onToRegisterPressed;
  final void Function() onAfterLoginChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: LoginView(
        onToRegisterPressed: onToRegisterPressed,
        onAfterLoginChanged: onAfterLoginChanged,
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
    required this.onToRegisterPressed,
    required this.onAfterLoginChanged,
  });

  final void Function() onToRegisterPressed;
  final void Function() onAfterLoginChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.formStatus == FormzStatus.submissionSuccess) {
          context.read<AuthenticationBloc>().add(GetUserInformation());
          onAfterLoginChanged.call();
        }
      },
      child: DissmissKeyboard(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: context.padding.top + 40,
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Đăng nhập',
                  style: theme.textTheme.displayMedium!.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text.rich(
                  TextSpan(
                    text: 'Nếu bạn chưa có tài khoản\nHãy',
                    style: theme.textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: ' Đăng ký ở đây',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = onToRegisterPressed.call,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
                const LoginEmailField(),
                const SizedBox(
                  height: 24,
                ),
                const LoginPasswordField(),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      'Quên mật khẩu?',
                      style: theme.textTheme.bodyMedium,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Center(
                  child: LoginButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
