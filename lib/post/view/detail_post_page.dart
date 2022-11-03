import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
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
          if (context.watch<AuthenticationBloc>().state.user != null) ...[
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
          ] else ...[
            IconButton(
              icon: Assets.icons.bookmarkOutline
                  .svg(color: theme.colorScheme.onSurfaceVariant),
              onPressed: () {},
            ),
            IconButton(
              icon: Assets.icons.share
                  .svg(color: theme.colorScheme.onSurfaceVariant),
              onPressed: () {},
            ),
          ]
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
                    CachedNetworkImageSlider(
                      height: 250,
                      images: post.medias.map((media) => media.url).toList(),
                      imageError: Assets.images.notImage.image().image,
                    )
                  else
                    Assets.images.notImage.image(
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BasicInformation(post: post),
                        const SizedBox(height: 16),
                        DetailInformation(post: post),
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
                        UtilInformation(post: post),
                        const Divider(
                          height: 32,
                        ),
                        DetailPostDescription(post: post),
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
                        if (post.groupProperties?.elementAt(1) != null) ...[
                          Text(
                            'Tiện ích',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: post.groupProperties!
                                .elementAt(1)
                                .properties
                                .map<Chip>(
                                  (property) => Chip(
                                    label: Text(property.displayName),
                                  ),
                                )
                                .toList(),
                          )
                        ] else
                          const SizedBox(),
                        const SizedBox(height: 16),
                        if (post.groupProperties?.first != null) ...[
                          Text(
                            'Địa điểm gần đó',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: post.groupProperties!.first.properties
                                .map<Chip>(
                                  (property) => Chip(
                                    label: Text(property.displayName),
                                  ),
                                )
                                .toList(),
                          )
                        ] else
                          const SizedBox(),
                        Text(
                          'Tin nhà trọ khác',
                          style: theme.textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const ConnectionPanel(),
        ],
      ),
    );
  }
}
