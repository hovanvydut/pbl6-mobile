import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/post/post.dart';
import 'package:pbl6_mobile/search_filter/search_filter.dart';
import 'package:post/post.dart';
import 'package:property/property.dart';
import 'package:widgets/widgets.dart';

class SearchFilterPage extends StatelessWidget {
  const SearchFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchFilterBloc(
        postRepository: context.read<PostRepository>(),
        addressRepository: context.read<AddressRepository>(),
        categoryRepository: context.read<CategoryRepository>(),
        propertyRepository: context.read<PropertyRepository>(),
      ),
      child: const SearchFilterView(),
    );
  }
}

class SearchFilterView extends StatelessWidget {
  const SearchFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return DissmissKeyboard(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            titleSpacing: 0,
            leading: IconButton(
              icon: Assets.icons.arrorLeft.svg(
                color: theme.colorScheme.onSurface,
                height: 32,
              ),
              onPressed: () => context.pop(),
            ),
            title: const PostSearchPanel(),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Assets.icons.filterOutline.svg(
                  height: 28,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                onPressed: null,
              )
            ],
          ),
        ),
        body: BlocBuilder<SearchFilterBloc, SearchFilterState>(
          builder: (context, state) {
            final loadingStatus = state.loadingStatus;
            if (loadingStatus == LoadingStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (loadingStatus == LoadingStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Assets.images.errorNotFound.svg(
                      height: 200,
                      width: 300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Đã có lỗi xảy ra, vui lòng thử lại',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              );
            }
            if (state.posts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Assets.images.empty.svg(
                      height: 200,
                      width: 300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Không có bài viết nào',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostListTileCard(post: post);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 8,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
