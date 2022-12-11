import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:media/media.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/edit_post/edit_post.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:post/post.dart';
import 'package:property/property.dart';
import 'package:widgets/widgets.dart';

class EditPostPage extends StatelessWidget {
  const EditPostPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditUserPostBloc(
        addressRepository: context.read<AddressRepository>(),
        categoryRepository: context.read<CategoryRepository>(),
        propertyRepository: context.read<PropertyRepository>(),
        postRepository: context.read<PostRepository>(),
        mediaRepository: context.read<MediaRepository>(),
      )..add(EditPageStarted(post)),
      child: EditPostView(
        post: post,
      ),
    );
  }
}

class EditPostView extends StatelessWidget {
  const EditPostView({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    const box24 = SizedBox(
      height: 24,
    );
    return BlocListener<EditUserPostBloc, EditUserPostState>(
      listenWhen: (previous, current) =>
          previous.loadingStatus != current.loadingStatus ||
          previous.editPostStatus != current.editPostStatus,
      listener: (context, state) {
        if (state.loadingStatus == LoadingStatus.error) {
          context.showSnackBar(
            message: 'Không thể lấy dữ liệu, vui lòng thử lại',
          );
        }
        if (state.editPostStatus == LoadingStatus.done) {
          context.read<UserPostBloc>().add(GetUserPosts());
          ToastHelper.showToast('Cập nhật bài viết thành công');
          context.go(AppRouter.main);
        }
        if (state.editPostStatus == LoadingStatus.error) {
          context.showSnackBar(
            message: 'Cập nhật bài viết thất bại, vui lòng thử lại',
          );
        }
      },
      child: DismissFocus(
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
              'Chỉnh sửa bài viêt',
            ),
            centerTitle: true,
          ),
          body: Builder(
            builder: (context) {
              final loadingStatus = context
                  .select((EditUserPostBloc bloc) => bloc.state.loadingStatus);

              return loadingStatus == LoadingStatus.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          EditingGeneralInformation(post: post),
                          box24,
                          EditingAddressInformation(post: post),
                          box24,
                          EditingDetailInformation(post: post),
                          box24,
                          EditingMoreInformation(post: post),
                          box24,
                          EditingMediaInformation(post: post),
                          box24,
                          BlocBuilder<EditUserPostBloc, EditUserPostState>(
                            buildWhen: (previous, current) =>
                                previous.editPostStatus !=
                                current.editPostStatus,
                            builder: (context, state) {
                              final uploaadPostStatus = state.editPostStatus;
                              return uploaadPostStatus == LoadingStatus.loading
                                  ? const CircularProgressIndicator()
                                  : FilledButton(
                                      child: const Text('Chỉnh sửa bài viêt'),
                                      onPressed: () => context
                                          .read<EditUserPostBloc>()
                                          .add(EditPostSubmitted(post: post)),
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
