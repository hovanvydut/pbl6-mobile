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
          context
            ..showSnackBar(
              message: 'Đăng ký thành công, vui lòng xác thực email của bạn',
            )
            ..pop();
        }
        if (state.formStatus.isSubmissionFailure) {
          context.showSnackBar(message: 'Đăng ký thất bại, vui lòng thử lại');
        }
      },
      child: DismissFocus(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: context.padding.top + 40,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 16,
                    left: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Đăng ký',
                        style: theme.textTheme.displayMedium?.copyWith(
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
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.pop(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const RegisterStepFlow()
                // const RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterStepFlow extends StatefulWidget {
  const RegisterStepFlow({
    super.key,
  });

  @override
  State<RegisterStepFlow> createState() => _RegisterStepFlowState();
}

class _RegisterStepFlowState extends State<RegisterStepFlow> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.7,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          RoleSelectionCard(
            onNextButtonPressed: () => pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
            ),
            child: RegisterForm(
              onBackPressed: () => pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
