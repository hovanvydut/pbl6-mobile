import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/register/bloc/register_bloc.dart';
import 'package:widgets/widgets.dart';

class RegisterDisplayNameField extends StatelessWidget {
  const RegisterDisplayNameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final displayName =
            context.select((RegisterBloc bloc) => bloc.state.displayName);
        return AppTextField(
          hintText: 'Tên hiển thị của bạn',
          labelText: 'Tên hiển thị',
          errorText:
              displayName.invalid ? getErrorText(displayName.error!) : null,
          onChanged: (value) {
            context
                .read<RegisterBloc>()
                .add(DisplayNameChanged(displayName: value));
          },
        );
      },
    );
  }

  String getErrorText(DislayNameValidationError error) {
    switch (error) {
      case DislayNameValidationError.empty:
        return 'Tên hiển thị không được để trống';
      case DislayNameValidationError.tooShort:
        return 'Tên hiển thị quá ngắn';
    }
  }
}
