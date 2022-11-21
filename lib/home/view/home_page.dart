import 'package:address/address.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/home/home.dart';
import 'package:pbl6_mobile/post/post.dart';
import 'package:widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        postBloc: context.read<PostBloc>(),
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

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
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
            Assets.images.logo.svg(),
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
            onPressed: () => context.push(
              AppRouter.searchFilter,
              extra: ExtraParams3<PostBloc, BookmarkBloc, int?>(
                param1: context.read<PostBloc>(),
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
          return SingleChildScrollView(
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
          );
        },
      ),
    );
  }
}

class SearchByDistrictView extends StatelessWidget {
  const SearchByDistrictView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final districts = [
      {
        'id': 1,
        'name': 'Thanh Khê',
        'imageUrl': 'https://file1.dangcongsan.vn/data/0/'
            'images/2022/07/26/giangntt/quang-canh-quan-thanh-khe.jpg'
      },
      {
        'id': 2,
        'name': 'Hải Châu',
        'imageUrl': 'https://cdn.baogiaothong.vn/upload/'
            '3-2022/images/2022-07-25/2-1658733315-112-width740height515.jpg'
      },
      {
        'id': 3,
        'name': 'Cẩm Lệ',
        'imageUrl': 'https://camle.danang.gov.vn/documents/10184/55713/1_'
            'trienlam.jpg/842b2a54-f058-4ae4-950a-3f610dc105e9?version=1.2&t='
            '1508900445000&imageThumbnail=0'
      },
      {
        'id': 4,
        'name': 'Liên Chiểu',
        'imageUrl': 'https://photo-cms-sggp.zadn.vn/w580/Uploaded/2022/chu'
            'kplu/2020_07_28/2402_yepz.jpg'
      },
      {
        'id': 5,
        'name': 'Ngũ Hành Sơn',
        'imageUrl': 'https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2017'
            '/08/Ngu-Hanh-Son-e1502127139914.png'
      },
      {
        'id': 6,
        'name': 'Sơn Trà',
        'imageUrl':
            'https://media.loveitopcdn.com/3426/160450-chua-linh-ung-6.jpg'
      },
      {
        'id': 7,
        'name': 'Huyện Hòa Vang',
        'imageUrl':
            'https://dulichdiaphuong.com/imgs/thanh-pho-da-nang/cau-vang.jpg'
      },
    ];
    return SizedBox(
      height: context.height * 0.2,
      child: ListView.separated(
        itemCount: districts.length,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final district = districts[index];
          return CachedNetworkImage(
            cacheManager: AppCacheManager.appConfig,
            imageUrl: district['imageUrl']! as String,
            imageBuilder: (context, imageProvider) => Hero(
              tag: district['imageUrl']! as String,
              child: AspectRatio(
                aspectRatio: 1.2,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.1, 0.4],
                          colors: [
                            Colors.black54,
                            Colors.transparent,
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        district['name']! as String,
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: context.colorScheme.surface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            placeholder: (context, url) => const AspectRatio(
              aspectRatio: 1,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: Assets.images.notImage.image().image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8);
        },
      ),
    );
  }
}
