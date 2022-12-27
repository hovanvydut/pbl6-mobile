import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:notification/notification.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/notification/notification.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:widgets/widgets.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(
        notificationRepository: context.read<NotificationRepository>(),
      )..add(PageStarted()),
      child: const NotificationView(),
    );
  }
}

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late final FocusNode _searchFocus;

  @override
  void initState() {
    super.initState();
    _searchFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listenWhen: (previous, current) =>
          previous.actionStatus != current.actionStatus,
      listener: (context, state) {
        if (state.actionStatus == LoadingStatus.done) {
          ToastHelper.showToast('Thực hiện thao tác thành công');
        }
        if (state.actionStatus == LoadingStatus.error) {
          ToastHelper.showToast('Thực hiện thao tác thất bại, xin thử lại');
        }
      },
      child: DismissFocus(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                icon: Assets.icons.arrorLeft.svg(
                  color: context.colorScheme.onSurface,
                  height: 32,
                ),
                onPressed: () => context.pop(),
              ),
              title: NotificationAppBarTitle(searchFocus: _searchFocus),
              actions: [
                NotificationSearchButton(searchFocus: _searchFocus),
                const PermissionWrapper(
                  permission: Permission.notificationUpdate,
                  child: ReadAllNotificationButton(),
                ),
              ],
              bottom: TabBar(
                indicatorColor: context.colorScheme.primary,
                labelColor: context.colorScheme.onSurface,
                unselectedLabelColor: context.colorScheme.onSurfaceVariant,
                unselectedLabelStyle: context.textTheme.titleSmall,
                tabs: const [
                  Tab(
                    icon: Text('Hôm nay'),
                  ),
                  Tab(
                    icon: Text('Tất cả'),
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                TodayNotificationListView(),
                NotificationListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
