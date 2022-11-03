import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/detail_post/detail_post.dart';
import 'package:pbl6_mobile/post/post.dart';
import 'package:post/post.dart';
import 'package:widgets/widgets.dart';

class DetailPostPage extends StatelessWidget {
  const DetailPostPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailPostCubit(
        post: post,
        postRepository: context.read<PostRepository>(),
      ),
      child: const DetailPostView(),
    );
  }
}

class DetailPostView extends StatelessWidget {
  const DetailPostView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return BlocBuilder<DetailPostCubit, DetailPostState>(
      builder: (context, state) {
        final post = state.post;
        final loadingStatus = state.loadingStatus;
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
                        param2: state.post,
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
                                context
                                    .read<PostBloc>()
                                    .add(DeleteUserPost(post));
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
          body: loadingStatus == LoadingStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
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
                                images: post.medias
                                    .map((media) => media.url)
                                    .toList(),
                                imageError:
                                    Assets.images.notImage.image().image,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                                    color: theme.colorScheme.outline
                                        .withOpacity(0.3),
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
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
                                      ),
                                      title: Text(
                                        '${post.address}, ${post.fullAddress}',
                                      ),
                                      trailing: Assets.icons.chevronRight.svg(
                                        height: 24,
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
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
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
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
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
                                      ),
                                      title: const Text('10/10/2021'),
                                      subtitle: const Text('30 ngày trước'),
                                    ),
                                  ),
                                  Text(
                                    'Người đăng',
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  ListTileTheme(
                                    data: const ListTileThemeData(
                                      minLeadingWidth: 24,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    child: ListTile(
                                      leading: CachedNetworkImage(
                                        imageUrl: post.authorInfo?.avatar ??
                                            'https://avatars.githubusercontent.com/u/63831488?v=4',
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                CircleAvatar(
                                          radius: 32,
                                          backgroundImage: imageProvider,
                                        ),
                                        placeholder: (context, url) =>
                                            CircleAvatar(
                                          radius: 32,
                                          backgroundColor:
                                              theme.colorScheme.surface,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            CircleAvatar(
                                          radius: 32,
                                          backgroundColor:
                                              theme.colorScheme.surface,
                                          child: Assets.icons.danger.svg(
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                      title: Text(post.authorInfo!.displayName),
                                      onTap: () => context.push(
                                        AppRouter.detailHost,
                                        extra: ExtraParams2<PostBloc, User>(
                                          param1: context.read<PostBloc>(),
                                          param2: post.authorInfo!,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (post.groupProperties!
                                      .firstWhere((group) => group.id == 2)
                                      .properties
                                      .isNotEmpty) ...[
                                    const SizedBox(height: 16),
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
                                    ),
                                    const SizedBox(height: 8),
                                  ] else
                                    const SizedBox(),
                                  if (post.groupProperties!
                                      .firstWhere((group) => group.id == 1)
                                      .properties
                                      .isNotEmpty) ...[
                                    const SizedBox(height: 16),
                                    Text(
                                      'Địa điểm gần đó',
                                      style: theme.textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      children: post
                                          .groupProperties!.first.properties
                                          .map<Chip>(
                                            (property) => Chip(
                                              label: Text(property.displayName),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    const SizedBox(height: 8),
                                  ] else
                                    const SizedBox(
                                      height: 16,
                                    ),
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
      },
    );
  }
}
