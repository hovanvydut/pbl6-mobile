import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/login/login.dart';
import 'package:pbl6_mobile/register/register.dart';
import 'package:pbl6_mobile/user_profile/user_profile.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserProfileBloc(),
        ),
      ],
      child: const MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late ValueNotifier<int> _currentIndexNotifier;

  @override
  void initState() {
    super.initState();
    _currentIndexNotifier = ValueNotifier(0);
  }

  void _changeCurrentIndex(int currentIndex) {
    _currentIndexNotifier.value = currentIndex;
    log(currentIndex.toString());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// TODO(dungngminh): think of another flow
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        return Scaffold(
          body: ValueListenableBuilder<int>(
            valueListenable: _currentIndexNotifier,
            builder: (context, currentIndex, child) {
              return IndexedStack(
                index: currentIndex,
                children: [
                  const Center(
                    child: Text('Trang chủ'),
                  ),
                  if (state.user == null)
                    AuthNavigationView(
                      onAfterLoginChanged: () {
                        if (state.user != null) {
                          _changeCurrentIndex(1);
                        }
                      },
                    )
                  else
                    const Center(child: Text('Thông báo')),
                  if (state.user != null) const SizedBox(),
                  if (state.user == null)
                    AuthNavigationView(
                      onAfterLoginChanged: () {
                        if (state.user != null) {
                          _changeCurrentIndex(3);
                        }
                      },
                    )
                  else
                    const Center(child: Text('Tin nhắn')),
                  if (state.user == null)
                    AuthNavigationView(
                      onAfterLoginChanged: () {
                        if (state.user != null) {
                          _changeCurrentIndex(4);
                        }
                      },
                    )
                  else
                    const UserProfilePage()
                ],
              );
            },
          ),
          floatingActionButton: state.user != null
              ? FloatingActionButton(
                  onPressed: () => context.push(AppRouter.uploadBlog),
                  child: Assets.icons.add.svg(),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: ValueListenableBuilder<int>(
            valueListenable: _currentIndexNotifier,
            builder: (context, currentIndex, child) {
              return NavigationBar(
                selectedIndex: currentIndex,
                onDestinationSelected: _changeCurrentIndex,
                destinations: [
                  NavigationDestination(
                    selectedIcon: Assets.icons.homeBold.svg(
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                    icon: Assets.icons.homeOutline.svg(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    label: 'Trang chủ',
                  ),
                  NavigationDestination(
                    selectedIcon: Assets.icons.notificationBold.svg(
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                    icon: Assets.icons.notificationOutline.svg(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    label: 'Thông báo',
                  ),
                  if (state.user != null)
                    const Visibility(
                      visible: false,
                      child: SizedBox(),
                    ),
                  NavigationDestination(
                    selectedIcon: Assets.icons.messageBold.svg(
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                    icon: Assets.icons.messageOutline.svg(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    label: 'Tin nhắn',
                  ),
                  NavigationDestination(
                    selectedIcon: Assets.icons.profileBold.svg(
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                    icon: Assets.icons.profileOutline.svg(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    label: 'Cá nhân',
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class AuthNavigationView extends StatefulWidget {
  const AuthNavigationView({
    super.key,
    required this.onAfterLoginChanged,
  });

  final VoidCallback onAfterLoginChanged;

  @override
  State<AuthNavigationView> createState() => _AuthNavigationViewState();
}

class _AuthNavigationViewState extends State<AuthNavigationView> {
  late PageController _pageAuthController;

  @override
  void initState() {
    super.initState();
    _pageAuthController = PageController();
  }

  @override
  void dispose() {
    _pageAuthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageAuthController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        LoginPage(
          onToRegisterPressed: () => _pageAuthController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          ),
          onAfterLoginChanged: widget.onAfterLoginChanged.call,
        ),
        RegisterPage(
          onToLogicPressed: () => _pageAuthController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          ),
        ),
      ],
    );
  }
}
