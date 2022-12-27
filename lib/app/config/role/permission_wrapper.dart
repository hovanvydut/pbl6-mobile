import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';

class PermissionWrapper extends StatelessWidget {
  const PermissionWrapper({
    super.key,
    required this.permission,
    required this.child,
  });

  final Permission permission;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final permissions = context.watch<AuthenticationBloc>().state.permissions;
    final isPermited = permissions.any(
      (e) => e == permission,
    );
    return Visibility(
      visible: isPermited,
      child: child,
    );
  }
}
