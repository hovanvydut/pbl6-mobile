import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/detail_host/detail_host.dart';
import 'package:pbl6_mobile/home/home.dart';
import 'package:post/post.dart';

class DetailHostPage extends StatelessWidget {
  const DetailHostPage({super.key, required this.host});

  final User host;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailHostCubit(
        host: host,
        postRepository: context.read<PostRepository>(),
      ),
      child: const DetailHostView(),
    );
  }
}

class DetailHostView extends StatelessWidget {
  const DetailHostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Assets.icons.arrorLeft.svg(
            color: Theme.of(context).colorScheme.onSurface,
            height: 32,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Builder(
        builder: (context) {
          final loadingStatus = context
              .select((DetailHostCubit cubit) => cubit.state.loadingStatus);
          final hostPosts = context.select(
            (DetailHostCubit cubit) => cubit.state.hostPosts,
          );
          if (loadingStatus == LoadingStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (loadingStatus == LoadingStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.errorNotFound.svg(
                    height: 200,
                    width: 300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Không thể lấy dữ liệu',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  )
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HostDetailInformation(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Tất cả bài viết',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: GridView.builder(
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  itemCount: hostPosts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 260,
                  ),
                  itemBuilder: (context, index) {
                    final post = hostPosts[index];
                    return Builder(
                      builder: (context) {
                        final bookmarks =
                            context.watch<BookmarkBloc>().state.bookmarks;
                        final isBookmarked = bookmarks.any(
                          (bookmark) => bookmark.id == post.id,
                        );
                        return PostGridCard(
                          post: post,
                          isBookmarked: isBookmarked,
                        );
                      },
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class HostDetailInformation extends StatelessWidget {
  const HostDetailInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Builder(
        builder: (context) {
          final host =
              context.select((DetailHostCubit cubit) => cubit.state.host);
          return Row(
            children: [
              CachedNetworkImage(
                imageUrl: host.avatar ??
                    'https://avatars.githubusercontent.com/u/63831488?v=4',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 40,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.5,
                  ),
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  child: Assets.icons.danger.svg(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
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
                      host.displayName,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                    Text(
                      host.userAccountEmail ?? 'Không có thông tin',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
