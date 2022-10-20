import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pbl6_mobile/login/login.dart';
import 'package:widgets/widgets.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.formStatus != current.formStatus,
      builder: (context, state) {
        return state.formStatus.isSubmissionInProgress
            ? const SizedBox.square(
                dimension: 48,
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: CircularProgressIndicator(),
                ),
              )
            : FilledButton(
                onPressed: state.formStatus.isValidated
                    ? () => context.read<LoginBloc>().add(LoginSubmitted())
                    : null,
                // onPressed: () => context.go(AppRouter.main),
                child: const Text(
                  'Đăng nhập',
                ),
              );
      },
    );
  }
}
