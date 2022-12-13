import 'package:address/address.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/home/home.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';
import 'package:post/post.dart';
import 'package:widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        postRepository: context.read<PostRepository>(),
        addressRepository: context.read<AddressRepository>(),
      ),
      lazy: false,
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _scrollController = ScrollController()
      ..addListener(
        () {
          if (_scrollController.hasClients &&
              _scrollController.position.pixels >=
                  _scrollController.position.maxScrollExtent) {
            if (context.read<HomeBloc>().state.loadMorePostStatus ==
                LoadingStatus.loading) return;
            EasyDebounce.debounce(
              'home_page_post',
              const Duration(milliseconds: 300),
              () => context.read<HomeBloc>().add(LoadMoreAllPosts()),
            );
          }
        },
      );
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final images = [
      'https://bandon.vn/uploads/posts/thiet-ke-nha-tro-dep-2020-bandon-0.jpg',
      'https://i.pinimg.com/736x/7d/cb/07/7dcb07b39f6e5a165112c62cbbb23c65.jpg',
      'https://xaydungthuanphuoc.com/wp-content/uploads/2022/09/mau-phong-tro-co-gac-lung-dep2013-7.jpg',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Assets.images.home.image(height: 32),
            const SizedBox(width: 8),
            Text(
              'HOMIE',
              style: context.theme.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 8),
            Text(
              'v${_packageInfo.version}',
              style: theme.textTheme.titleMedium,
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Assets.icons.searchBold.svg(
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () => context.pushToChild(
              AppRouter.searchFilter,
              extra: ExtraParams3<UserPostBloc, BookmarkBloc, int?>(
                param1: context.read<UserPostBloc>(),
                param2: context.read<BookmarkBloc>(),
                param3: null,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final homeLoadingStatus = state.homeLoadingStatus;
          if (homeLoadingStatus == LoadingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () async => context.read<HomeBloc>().add(GetAllPosts()),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImageSlider(
                    images: images,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    borderRadius: BorderRadius.circular(20),
                    height: context.height * 0.28,
                    imageError: Assets.images.notImage.image().image,
                    onTapToViewImage: false,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Xu hướng tìm kiếm',
                          style: context.textTheme.titleLarge,
                        ),
                      ),
                      const SearchByDistrictView(),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Phòng trọ nổi bật',
                          style: context.textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                  const PriorityPostGridView(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
