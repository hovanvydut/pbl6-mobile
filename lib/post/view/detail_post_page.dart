import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/post/post.dart';
import 'package:widgets/widgets.dart';

class DetailPostPage extends StatelessWidget {
  const DetailPostPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Assets.icons.arrorLeft.svg(
            color: theme.colorScheme.onSurface,
            height: 32,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text('Chi tiết phòng'),
        actions: <Widget>[
          IconButton(
            icon: Assets.icons.edit
                .svg(color: theme.colorScheme.onSurfaceVariant),
            onPressed: () {
              context.push(
                AppRouter.editPost,
                extra: ExtraParams2<PostBloc, Post>(
                  param1: context.read<PostBloc>(),
                  param2: post,
                ),
              );
            },
          ),
          IconButton(
            icon: Assets.icons.delete
                .svg(color: theme.colorScheme.onSurfaceVariant),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Xóa bài viết'),
                    content: const Text(
                      'Bạn có muốn xóa bài viết',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.read<PostBloc>().add(DeleteUserPost(post));
                          context.pop();
                        },
                        child: const Text('Đồng ý'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Hủy'),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (post.medias.isNotEmpty)
                    CachedNetworkImage(
                      cacheManager: AppCacheManager.appConfig,
                      imageUrl: post.medias.first.url,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Assets.images.notImage.image(
                        fit: BoxFit.cover,
                        height: 250,
                      ),
                    )
                  else
                    Assets.images.notImage.image(
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          post.category.name,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: theme.colorScheme.onSurface),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          post.title,
                          style: theme.textTheme.headlineMedium
                              ?.copyWith(color: theme.colorScheme.onSurface),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'Giá phòng: ',
                            style: theme.textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text:
                                    '${post.price.inCompactLongCurrency} / tháng',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Tối đa',
                                  style: theme.textTheme.labelLarge,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '${post.limitTenant} người',
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Diện tích',
                                  style: theme.textTheme.labelLarge,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '${post.area.toStringAsFixed(0)}m²',
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Đặt cọc',
                                  style: theme.textTheme.labelLarge,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  post.prePaidPrice.inCompactCurrencyNotSymbol,
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                          endIndent: 24,
                          indent: 24,
                          color: theme.colorScheme.outline.withOpacity(0.3),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Assets.icons.lightBulb.svg(
                                  height: 28,
                                  color: theme.colorScheme.outline,
                                ),
                                Text(
                                  8000.inCompactCurrencyNotSymbol,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onBackground,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Assets.icons.waterDrop.svg(
                                  height: 28,
                                  color: theme.colorScheme.outline,
                                ),
                                Text(
                                  40000.inCompactCurrencyNotSymbol,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onBackground,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Assets.icons.wifi.svg(
                                  height: 28,
                                  color: theme.colorScheme.outline,
                                ),
                                Text(
                                  'Miễn phí',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onBackground,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Divider(
                          height: 32,
                        ),
                        Text(
                          'Chi tiết',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post.description,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Địa chỉ và liên hệ',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        ListTileTheme(
                          data: const ListTileThemeData(
                            minLeadingWidth: 24,
                            contentPadding: EdgeInsets.zero,
                          ),
                          child: ListTile(
                            leading: Assets.icons.position.svg(
                              height: 24,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            title: Text('${post.address}, ${post.fullAddress}'),
                            trailing: Assets.icons.chevronRight.svg(
                              height: 24,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        ListTileTheme(
                          data: const ListTileThemeData(
                            minLeadingWidth: 24,
                            contentPadding: EdgeInsets.zero,
                          ),
                          child: ListTile(
                            leading: Assets.icons.callOutline.svg(
                              height: 24,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            title: const Text('Số điện thoại'),
                            subtitle: const Text('0702479981'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Ngày đăng',
                          style: theme.textTheme.titleLarge,
                        ),
                        ListTileTheme(
                          data: const ListTileThemeData(
                            minLeadingWidth: 24,
                            contentPadding: EdgeInsets.zero,
                          ),
                          child: ListTile(
                            leading: Assets.icons.calendar2.svg(
                              height: 24,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            title: const Text('10/10/2021'),
                            subtitle: const Text('30 ngày trước'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tiện ích',
                          style: theme.textTheme.titleLarge,
                        ),
                        ListTileTheme(
                          data: const ListTileThemeData(
                            minLeadingWidth: 24,
                            contentPadding: EdgeInsets.zero,
                          ),
                          child: ListTile(
                            leading: Assets.icons.calendar2.svg(
                              height: 24,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            title: const Text('10/10/2021'),
                            subtitle: const Text('30 ngày trước'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Địa điểm gần đó',
                          style: theme.textTheme.titleLarge,
                        ),
                        ListTileTheme(
                          data: const ListTileThemeData(
                            minLeadingWidth: 24,
                            contentPadding: EdgeInsets.zero,
                          ),
                          child: ListTile(
                            leading: Assets.icons.calendar2.svg(
                              height: 24,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            title: const Text('10/10/2021'),
                            subtitle: const Text('30 ngày trước'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilledButtonWithIcon(
                  onPressed: () {},
                  icon: Assets.icons.messageOutline.svg(
                    color: theme.colorScheme.onPrimary,
                  ),
                  label: const Text(
                    'Chat ngay',
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Đặt lịch xem trọ',
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Assets.icons.callOutline.svg(height: 20),
                  label: const Text(
                    'Gọi',
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
