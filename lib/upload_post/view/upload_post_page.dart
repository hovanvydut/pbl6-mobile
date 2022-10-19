import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/upload_post/upload_post.dart';
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
          previous.loadingStatus != current.loadingStatus,
      listener: (context, state) {
        if (state.loadingStatus == LoadingStatus.done) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('done'),
            ),
          );
        }
      },
      child: DissmissKeyboard(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: context.padding.top),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Assets.icons.arrorLeft.svg(
                          color: theme.colorScheme.primary,
                          height: 32,
                        ),
                        onPressed: () => context.pop(),
                      ),
                      Text('Đăng bài mới', style: theme.textTheme.titleLarge),
                      Opacity(
                        opacity: 0,
                        child: IconButton(
                          icon: Assets.icons.arrorLeft.svg(
                            color: theme.colorScheme.primary,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
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
                        FilledButton(
                          child: const Text('Đăng bài viết'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
