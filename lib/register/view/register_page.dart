import 'package:auth/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/register/register.dart';
import 'package:widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.formStatus.isSubmissionSuccess) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Đăng ký thành công, vui lòng xác thực email của bạn'),
              duration: Duration(milliseconds: 1500),
            ),
          );
          context.pop();
        }
        if (state.formStatus.isSubmissionFailure) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đăng ký thất bại, vui lòng thử lại'),
              duration: Duration(milliseconds: 1500),
            ),
          );
        }
      },
      child: DissmissFocus(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: context.padding.top + 40,
              right: 16,
              left: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Đăng ký',
                  style: theme.textTheme.displayMedium!.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 32),
                Text.rich(
                  TextSpan(
                    text: 'Nếu bạn đã có tài khoản\nHãy',
                    style: theme.textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: ' Đăng nhập ở đây',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.pop(),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 64),
                const RegisterEmailField(),
                const SizedBox(height: 24),
                const RegisterDisplayNameField(),
                const SizedBox(height: 24),
                const RegisterPasswordField(),
                const SizedBox(height: 24),
                const RegisterConfirmationPasswordField(),
                const SizedBox(height: 48),
                const Center(
                  child: RegisterButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
