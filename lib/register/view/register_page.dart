import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/register/register.dart';
import 'package:widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return DissmissKeyboard(
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
              const RegisterPasswordField(),
              const SizedBox(height: 24),
              const RegisterConfirmationPasswordField(),
              const SizedBox(height: 48),
              const Center(
                child: RegisterButton(),
              ),
              const SizedBox(
                height: 80,
              ),
              Column(
                children: [
                  Text(
                    'Hoặc đăng nhập với',
                    style: theme.textTheme.bodyMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Assets.images.social.google.svg(),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Assets.images.social.facebook.svg(height: 40),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
