import 'package:auth/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/login/login.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.formStatus == FormzStatus.submissionSuccess) {
          context.read<AuthenticationBloc>().add(GetUserInformation());
          ToastHelper.showToast('Đăng nhập thành công');
          context.go(AppRouter.main);
        }
        if (state.formStatus == FormzStatus.submissionFailure) {
          context.showSnackBar(message: state.errorMessage);
          
        }
      },
      child: DismissFocus(
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
                          ..onTap = () => context.push(AppRouter.register),
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
