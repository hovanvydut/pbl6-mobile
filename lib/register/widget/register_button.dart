import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pbl6_mobile/register/register.dart';
import 'package:widgets/widgets.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
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
                    ? () =>
                        context.read<RegisterBloc>().add(RegisterSubmitted())
                    : null,
                child: const Text(
                  'Đăng ký',
                ),
              );
      },
    );
  }
}
