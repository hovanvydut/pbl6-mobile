import 'package:flutter/material.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/home/view/home_page.dart';
import 'package:pbl6_mobile/user_profile/user_profile.dart';

class GuestMainView extends StatefulWidget {
  const GuestMainView({super.key});

  @override
  State<GuestMainView> createState() => _GuestMainViewState();
}

class _GuestMainViewState extends State<GuestMainView> {
  late ValueNotifier<int> _currentIndexNotifier;

  @override
  void initState() {
    super.initState();
    _currentIndexNotifier = ValueNotifier(0);
  }

  void _changeCurrentIndex(int currentIndex) {
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
          return IndexedStack(
            index: currentIndex,
            children: const [
              HomePage(),
              Center(child: Text('Thông báo')),
              Center(child: Text('Tin nhắn')),
              UserProfilePage()
            ],
          );
        },
      ),
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
