import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainView();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('MainView is working'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRouter.uploadBlog),
        child: Assets.icons.add.svg(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentIndexNotifier,
        builder: (context, currentIndex, child) {
          return NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: _changeCurrentIndex,
            destinations: [
              NavigationDestination(
                selectedIcon: Assets.icons.homeBold.svg(),
                icon: Assets.icons.homeOutline.svg(),
                label: 'Trang chủ',
              ),
              NavigationDestination(
                selectedIcon: Assets.icons.notificationBold.svg(),
                icon: Assets.icons.notificationOutline.svg(),
                label: 'Thông báo',
              ),
              const Visibility(
                visible: false,
                child: SizedBox(),
              ),
              NavigationDestination(
                selectedIcon: Assets.icons.messageBold.svg(),
                icon: Assets.icons.messageOutline.svg(),
                label: 'Tin nhắn',
              ),
              NavigationDestination(
                selectedIcon: Assets.icons.profileBold.svg(),
                icon: Assets.icons.profileOutline.svg(),
                label: 'Cá nhân',
              ),
            ],
          );
        },
      ),
    );
  }
}
