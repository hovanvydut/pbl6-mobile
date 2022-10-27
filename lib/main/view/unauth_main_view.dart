import 'package:flutter/material.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/home/home.dart';

class UnAuthMainView extends StatefulWidget {
  const UnAuthMainView({super.key});

  @override
  State<UnAuthMainView> createState() => _UnAuthMainViewState();
}

class _UnAuthMainViewState extends State<UnAuthMainView> {
  late ValueNotifier<int> _currentIndexNotifier;

  @override
  void initState() {
    super.initState();
    _currentIndexNotifier = ValueNotifier(0);
  }

  void _changeCurrentIndex(BuildContext context, {required int currentIndex}) {
    if (currentIndex != 0) {
      context.push(AppRouter.login);
      return;
    }
    _currentIndexNotifier.value = currentIndex;
  }

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _currentIndexNotifier,
        builder: (context, currentIndex, child) {
          return LazyIndexedStack(
            index: currentIndex,
            children: const [
              HomePage(),
              Center(child: Text('Thông báo')),
              Center(child: Text('Tin nhắn')),
              Center(child: Text('Trang cá nhân')),
            ],
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentIndexNotifier,
        builder: (context, currentIndex, child) {
          return NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) =>
                _changeCurrentIndex(context, currentIndex: index),
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
  }
}
