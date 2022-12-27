import 'package:flutter/material.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/register/register.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.onBackPressed,
  });

  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        IconButton(
          icon: Assets.icons.arrorLeft.svg(),
          onPressed: onBackPressed,
        ),
        const SizedBox(height: 8),
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
    );
  }
}
