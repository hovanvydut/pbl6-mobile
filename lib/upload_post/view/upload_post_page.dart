import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:media/media.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/post/post.dart';
import 'package:pbl6_mobile/upload_post/upload_post.dart';
import 'package:post/post.dart';
import 'package:property/property.dart';
import 'package:widgets/widgets.dart';

class UploadPostPage extends StatelessWidget {
  const UploadPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadPostBloc(
        addressRepository: context.read<AddressRepository>(),
        categoryRepository: context.read<CategoryRepository>(),
        propertyRepository: context.read<PropertyRepository>(),
        postRepository: context.read<PostRepository>(),
        mediaRepository: context.read<MediaRepository>(),
      ),
      child: const UploadPostView(),
    );
  }
}

class UploadPostView extends StatelessWidget {
  const UploadPostView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    const box24 = SizedBox(height: 24);
    return BlocListener<UploadPostBloc, UploadPostState>(
      listenWhen: (previous, current) =>
          previous.loadingStatus != current.loadingStatus ||
          previous.uploadPostStatus != current.uploadPostStatus,
      listener: (context, state) {
        if (state.loadingStatus == LoadingStatus.error) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Không thể lấy dữ liệu, vui lòng thử lại'),
              duration: Duration(seconds: 2),
            ),
          );
        }
        if (state.uploadPostStatus == LoadingStatus.done) {
          context.read<PostBloc>().add(GetUserPosts());
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đăng bài viết thành công'),
              duration: Duration(milliseconds: 1500),
            ),
          );
          context.pop();
        }
        if (state.uploadPostStatus == LoadingStatus.error) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đăng bài viết thất bại, vui lòng thử lại'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: DissmissKeyboard(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Assets.icons.arrorLeft.svg(
                color: theme.colorScheme.onSurface,
                height: 32,
              ),
              onPressed: () => context.pop(),
            ),
            title: const Text(
              'Đăng bài mới',
            ),
            centerTitle: true,
          ),
          body: Builder(
            builder: (context) {
              final loadingStatus = context
                  .select((UploadPostBloc bloc) => bloc.state.loadingStatus);

              return loadingStatus == LoadingStatus.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const PostGeneralInformation(),
                          box24,
                          const PostAddressInformation(),
                          box24,
                          const PostDetailInformation(),
                          box24,
                          const PostMoreInformation(),
                          box24,
                          const PostMediaInformation(),
                          box24,
                          BlocBuilder<UploadPostBloc, UploadPostState>(
                            buildWhen: (previous, current) =>
                                previous.uploadPostStatus !=
                                current.uploadPostStatus,
                            builder: (context, state) {
                              final uploaadPostStatus = state.uploadPostStatus;
                              return uploaadPostStatus == LoadingStatus.loading
                                  ? const CircularProgressIndicator()
                                  : FilledButton(
                                      child: const Text('Đăng bài viết'),
                                      onPressed: () => context
                                          .read<UploadPostBloc>()
                                          .add(UploadPostSubmiited()),
                                    );
                            },
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
