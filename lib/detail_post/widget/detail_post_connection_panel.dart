import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/detail_post/detail_post.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widgets/widgets.dart';

class DetailPostConnectionPanel extends StatelessWidget {
  const DetailPostConnectionPanel({
    super.key,
    this.isLogged = false,
    this.visiable = true,
  });

  final bool isLogged;
  final bool visiable;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Visibility(
      visible: visiable,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Container(
            height: context.height * 0.12,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButtonWithIcon(
                  onPressed: isLogged
                      ? () {}
                      : () {
                          ToastHelper.showToast(
                            'Bạn phải đăng nhập mới thực hành động này',
                          );
                          context.push(AppRouter.login);
                        },
                  icon: Assets.icons.messageOutline.svg(
                    color: theme.colorScheme.onPrimary,
                  ),
                  label: const Text('Chat ngay'),
                ),
                PermissionWrapper(
                  permission: Permission.bookingCreateMeeting,
                  child: OutlinedButton(
                    onPressed: isLogged
                        ? () => context.pushToChild(
                              AppRouter.booking,
                              extra: ExtraParams3<UserPostBloc, Post,
                                  BookmarkBloc>(
                                param1: context.read<UserPostBloc>(),
                                param2:
                                    context.read<DetailPostCubit>().state.post,
                                param3: context.read<BookmarkBloc>(),
                              ),
                            )
                        : () {
                            ToastHelper.showToast(
                              'Bạn phải đăng nhập mới thực hành động này',
                            );
                            context.push(AppRouter.login);
                          },
                    child: const Text('Đặt lịch xem trọ'),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () => launchUrl(
                    Uri(
                      scheme: 'tel',
                      path: context
                          .read<DetailPostCubit>()
                          .state
                          .post
                          .authorInfo!
                          .phoneNumber,
                    ),
                  ),
                  icon: Assets.icons.callOutline
                      .svg(height: 20, color: context.colorScheme.primary),
                  label: const Text('Gọi'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
