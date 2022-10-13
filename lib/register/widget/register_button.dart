import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';


class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return FilledButton(
          child: const Text('Đăng ký'),
          onPressed: () {},
        );
      },
    );
  }
}