import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/register/register.dart';
import 'package:widgets/widgets.dart';

class RoleSelectionCard extends StatelessWidget {
  const RoleSelectionCard({
    super.key,
    required this.onNextButtonPressed,
  });

  final VoidCallback? onNextButtonPressed;

  @override
  Widget build(BuildContext context) {
    final selectedRole =
        context.select((RegisterBloc bloc) => bloc.state.selectedRole);
    return Column(
      children: [
        const SizedBox(height: 32),
        RoleCard(
          role: Role.host,
          isSelected: selectedRole == Role.host,
          onTap: () {
            context
                .read<RegisterBloc>()
                .add(const RolePressed(role: Role.host));
          },
        ),
        const SizedBox(height: 16),
        RoleCard(
          role: Role.guest,
          isSelected: selectedRole == Role.guest,
          onTap: () {
            context
                .read<RegisterBloc>()
                .add(const RolePressed(role: Role.guest));
          },
        ),
        const SizedBox(
          height: 24,
        ),
        FilledButton(
          onPressed: selectedRole == null ? null : onNextButtonPressed,
          child: const Text('Tiếp tục'),
        ),
      ],
    );
  }
}
