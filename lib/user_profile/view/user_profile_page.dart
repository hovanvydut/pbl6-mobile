import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/post/post.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final height = context.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: theme.colorScheme.secondaryContainer,
            height: height * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 8) +
                EdgeInsets.only(top: context.padding.top + 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // BlocBuilder<UserProfileBloc, UserProfileState>(
                    //   builder: (context, state) {
                    //     if (!state.isInHostPanel) {
                    //       return IconButton(
                    //         tooltip: 'Truy cập giao diện trang chủ',
                    //         icon: Assets.icons.homeOutline.svg(
                    //           color: theme.colorScheme.onSecondaryContainer,
                    //           height: 28,
                    //         ),
                    //         onPressed: () {
                    //           context
                    //               .read<UserProfileBloc>()
                    //               .add(SwitchToHomePressed());
                    //           context.push(AppRouter.guest);
                    //         },
                    //       );
                    //     }
                    //     return IconButton(
                    //       tooltip: 'Truy cập giao diện chủ trọ',
                    //       icon: Assets.icons.document.svg(
                    //         color: theme.colorScheme.onSecondaryContainer,
                    //         height: 28,
                    //       ),
                    //       onPressed: () {
                    //         context
                    //             .read<UserProfileBloc>()
                    //             .add(SwitchToHomePressed());
                    //         context.go(AppRouter.host);
                    //       },
                    //     );
                    //   },
                    // ),
                    IconButton(
                      icon: Assets.icons.setting.svg(
                        color: theme.colorScheme.onSecondaryContainer,
                        height: 28,
                      ),
                      onPressed: () => context
                          .read<AuthenticationBloc>()
                          .add(LogoutRequested()),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    final user = state.user;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: user?.avatar ??
                                  'https://avatars.githubusercontent.com/u/63831488?v=4',
                              imageBuilder: (context, imageProvider) =>
                                  GestureDetector(
                                onTap: () => context.pushToViewImage(
                                  user?.avatar ??
                                      'https://avatars.githubusercontent.com/u/63831488?v=4',
                                ),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: imageProvider,
                                ),
                              ),
                              placeholder: (context, url) => CircleAvatar(
                                radius: 40,
                                backgroundColor: theme.colorScheme.surface,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                radius: 40,
                                backgroundColor: theme.colorScheme.surface,
                                child: Assets.icons.danger
                                    .svg(color: theme.colorScheme.onSurface),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user?.displayName ?? 'Không có thông tin',
                                    style: theme.textTheme.titleLarge!.copyWith(
                                      color: theme
                                          .colorScheme.onSecondaryContainer,
                                    ),
                                  ),
                                  Text(
                                    user?.userAccountEmail ??
                                        'Không có thông tin',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Spacer()
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: height * 0.25,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Assets.icons.user.svg(
                          color: theme.colorScheme.onSurface,
                        ),
                        title: const Text('Thông tin cá nhân'),
                        trailing: Assets.icons.chevronRight
                            .svg(color: theme.colorScheme.onSurface),
                        onTap: () {
                          context.pushToChild(
                            AppRouter.editUserProfile,
                            extra:
                                context.read<AuthenticationBloc>().state.user,
                          );
                        },
                      ),
                      ListTile(
                        leading: Assets.icons.bookmarkOutline.svg(
                          color: theme.colorScheme.onSurface,
                        ),
                        title: const Text('Bài đăng đã lưu'),
                        trailing: Assets.icons.chevronRight
                            .svg(color: theme.colorScheme.onSurface),
                        onTap: () => context.push(
                          AppRouter.bookmark,
                          extra: ExtraParams2<BookmarkBloc, PostBloc>(
                            param1: context.read<BookmarkBloc>(),
                            param2: context.read<PostBloc>(),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Assets.icons.calendar.svg(
                          color: theme.colorScheme.onSurface,
                        ),
                        title: const Text('Lịch xem trọ'),
                        trailing: Assets.icons.chevronRight
                            .svg(color: theme.colorScheme.onSurface),
                        onTap: () => context.pushToChild(AppRouter.bookingList),
                      ),
                      Builder(
                        builder: (context) {
                          final user =
                              context.watch<AuthenticationBloc>().state.user;
                          return ListTile(
                            leading: Assets.icons.wallet.svg(
                              color: theme.colorScheme.onSurface,
                            ),
                            title: const Text('Số dư hiện tại'),
                            subtitle: Text('${user?.currentCredit ?? 0} đồng'),
                            trailing: Assets.icons.chevronRight
                                .svg(color: theme.colorScheme.onSurface),
                            onTap: () => context.push(AppRouter.payment),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
