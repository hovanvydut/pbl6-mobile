import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/l10n/l10n.dart';
import 'package:pbl6_mobile/login/login.dart';
import 'package:widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DissmissKeyboard(
      child: BlocProvider(
        create: (context) => LoginBloc(),
        child: const LoginView(),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          // top: context.padding.top + 32,
          left: 16,
          right: 16,
          bottom: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(
              flex: 2,
            ),
            Text(
              l10n.login,
              style: theme.textTheme.headline4,
            ),
            const Spacer(
              flex: 2,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: AppPalette.whiteBackgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
              height: 64,
              child: TextField(
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppPalette.primaryColor,
                      width: 2,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                  floatingLabelStyle: const TextStyle(
                    color: AppPalette.primaryColor,
                    fontSize: 16,
                  ),
                  labelText: l10n.email,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: AppPalette.whiteBackgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
              height: 64,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppPalette.primaryColor,
                      width: 2,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                  floatingLabelStyle: const TextStyle(
                    color: AppPalette.primaryColor,
                    fontSize: 16,
                  ),
                  labelText: l10n.password,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  l10n.forgotPassword,
                  style: theme.textTheme.bodyText2,
                ),
                const SizedBox(
                  width: 8,
                ),
                Assets.icons.arrorRight.svg()
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              height: 48,
              onPressed: () {},
              child: Text(
                l10n.login.toUpperCase(),
                style: theme.textTheme.button,
              ),
            ),
            const Spacer(
              flex: 5,
            ),
            Center(
              child: Text(
                l10n.loginWithSocial,
                style: theme.textTheme.bodyText2,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => context.push(AppRouter.register),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                    height: 64,
                    width: 92,
                    decoration: BoxDecoration(
                      color: AppPalette.whiteBackgroundColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                          color: AppPalette.shadowColor,
                        )
                      ],
                    ),
                    child: Assets.icons.google.svg(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  height: 64,
                  width: 92,
                  decoration: BoxDecoration(
                    color: AppPalette.whiteBackgroundColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        offset: const Offset(0, 1),
                        color: AppPalette.shadowColor,
                      )
                    ],
                  ),
                  child: Assets.icons.facebook.svg(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
