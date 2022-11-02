import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:easy_debounce/easy_debounce.dart';
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
    return DissmissFocus(
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
            actions: const [SearchFilterActionButton()],
          ),
        ),
        body: const SearchFilterBodyView(),
      ),
    );
  }
}

class SearchFilterActionButton extends StatelessWidget {
  const SearchFilterActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final filterButton = IconButton(
      icon: Assets.icons.filterBold.svg(
        height: 28,
        color: theme.colorScheme.onSurface,
      ),
      onPressed: () {
        showModalBottomSheet(
          elevation: 1,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          isScrollControlled: true,
          builder: (_) {
            return BlocProvider.value(
              value: context.read<SearchFilterBloc>(),
              child: const FilterChoicePanel(),
            );
          },
        );
      },
    );
    final refreshButton = IconButton(
      icon: Assets.icons.refresh.svg(color: theme.colorScheme.onSurface),
      onPressed: () => context.read<SearchFilterBloc>().add(GetPosts()),
    );
    return BlocBuilder<SearchFilterBloc, SearchFilterState>(
      builder: (context, state) {
        final loadingStatus = state.loadingStatus;
        switch (loadingStatus) {
          case LoadingStatus.initial:
          case LoadingStatus.loading:
          case LoadingStatus.error:
            return refreshButton;
          case LoadingStatus.done:
            if (state.posts.isEmpty) {
              return refreshButton;
            }
            return filterButton;
        }
      },
    );
  }
}

class FilterChoicePanel extends StatelessWidget {
  const FilterChoicePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return DissmissFocus(
      child: Container(
        height: context.height * 0.9,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const Center(child: SheetDragHandle()),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Loại phòng',
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<SearchFilterBloc, SearchFilterState>(
                      builder: (context, state) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            child: Wrap(
                              spacing: 8,
                              children: state.houseTypesData
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => Builder(
                                      builder: (context) {
                                        final houseTypeSelected =
                                            context.select(
                                          (SearchFilterBloc bloc) =>
                                              bloc.state.houseTypeSelected,
                                        );
                                        return FilterChip(
                                          label: Text(entry.value.name),
                                          onSelected: (_) => context
                                              .read<SearchFilterBloc>()
                                              .add(
                                                HouseTypeSelected(
                                                  entry.value.id,
                                                ),
                                              ),
                                          selected: houseTypeSelected ==
                                              entry.value.id,
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mức giá',
                            style: theme.textTheme.headlineSmall!.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              final priceRange = context.select(
                                (SearchFilterBloc bloc) =>
                                    bloc.state.priceRange,
                              );
                              return Text(
                                'Từ '
                                '${priceRange.start.inCompactCurrencyNotSymbol}'
                                ' đến ${priceRange.end.inCompactLongCurrency}',
                                style: theme.textTheme.bodyMedium,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<SearchFilterBloc, SearchFilterState>(
                      buildWhen: (previous, current) =>
                          previous.priceRange != current.priceRange,
                      builder: (context, state) {
                        return RangeSlider(
                          max: 15000000,
                          labels: RangeLabels(
                            state.priceRange.start.inCompactCurrencyNotSymbol,
                            state.priceRange.end.inCompactCurrencyNotSymbol,
                          ),
                          min: 500000,
                          divisions: 10,
                          onChanged: (priceRange) => context
                              .read<SearchFilterBloc>()
                              .add(PriceRangeChanged(priceRange)),
                          values: state.priceRange,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Diện tích phòng',
                            style: theme.textTheme.headlineSmall!.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              final areaRange = context.select(
                                (SearchFilterBloc bloc) => bloc.state.areaRange,
                              );
                              return Text(
                                'Từ ${areaRange.start.toStringAsFixed(0)}m² '
                                'đến ${areaRange.end.toStringAsFixed(0)}m²',
                                style: theme.textTheme.bodyMedium,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<SearchFilterBloc, SearchFilterState>(
                      buildWhen: (previous, current) =>
                          previous.areaRange != current.areaRange,
                      builder: (context, state) {
                        return RangeSlider(
                          max: 30,
                          labels: RangeLabels(
                            state.areaRange.start.inCompactCurrencyNotSymbol,
                            state.areaRange.end.inCompactCurrencyNotSymbol,
                          ),
                          divisions: 10,
                          onChanged: (areaRange) => context
                              .read<SearchFilterBloc>()
                              .add(AreaRangeChanged(areaRange)),
                          values: state.areaRange,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Khu vực',
                            style: theme.textTheme.headlineSmall!.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              final selectedDistrict = context.select(
                                (SearchFilterBloc bloc) =>
                                    bloc.state.selectedDistrict,
                              );
                              return Visibility(
                                visible: selectedDistrict != 0,
                                child: TextButton(
                                  child: const Text('Chọn lại'),
                                  onPressed: () => context
                                      .read<SearchFilterBloc>()
                                      .add(const DistrictSelected('${0}')),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BlocBuilder<SearchFilterBloc, SearchFilterState>(
                        builder: (context, state) {
                          return AppDropDownField<String>(
                            labelText: 'Quận/Huyện',
                            value: state.selectedDistrict == 0
                                ? null
                                : state.selectedDistrict.toString(),
                            items: state.districtsData
                                .map<DropdownMenuItem<String>>(
                                  (district) => DropdownMenuItem(
                                    value: district.id.toString(),
                                    child: Text(district.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (district) {
                              if (district != null) {
                                context
                                    .read<SearchFilterBloc>()
                                    .add(DistrictSelected(district));
                              }
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BlocBuilder<SearchFilterBloc, SearchFilterState>(
                        builder: (context, state) {
                          return AppDropDownField<String>(
                            labelText: 'Phường/Xã',
                            value: state.selectedWard == 0
                                ? null
                                : state.selectedWard.toString(),
                            items: state.wardsData
                                .map<DropdownMenuItem<String>>(
                                  (ward) => DropdownMenuItem(
                                    value: ward.id.toString(),
                                    child: Text(ward.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (ward) {
                              if (ward != null) {
                                context
                                    .read<SearchFilterBloc>()
                                    .add(WardSelected(ward));
                              }
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Tiện ích khác',
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<SearchFilterBloc, SearchFilterState>(
                      builder: (context, state) {
                        final otherUtils = state.otherUtilsData;
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 3.4,
                            height: 100,
                            child: Wrap(
                              spacing: 8,
                              runAlignment: WrapAlignment.spaceEvenly,
                              children: otherUtils
                                  .map<Builder>(
                                    (utilData) => Builder(
                                      builder: (context) {
                                        final selectedUtils = context
                                            .watch<SearchFilterBloc>()
                                            .state
                                            .selectedOtherUtils;
                                        final isUtilExisted = selectedUtils.any(
                                          (util) => util == utilData.id,
                                        );
                                        return FilterChip(
                                          label: Text(utilData.displayName),
                                          onSelected: (_) => context
                                              .read<SearchFilterBloc>()
                                              .add(
                                                OtherUtilSelected(
                                                  utilData.id,
                                                ),
                                              ),
                                          selected: isUtilExisted,
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Đối tượng cho thuê',
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<SearchFilterBloc, SearchFilterState>(
                      builder: (context, state) {
                        final rentalObjects = state.rentalObjectsData;
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            child: Wrap(
                              spacing: 8,
                              runAlignment: WrapAlignment.spaceEvenly,
                              children: rentalObjects
                                  .map<Builder>(
                                    (objData) => Builder(
                                      builder: (context) {
                                        final selectedObjs = context
                                            .watch<SearchFilterBloc>()
                                            .state
                                            .selectedRentailObjects;
                                        final isObjExisted = selectedObjs.any(
                                          (obj) => obj == objData.id,
                                        );
                                        return FilterChip(
                                          label: Text(objData.displayName),
                                          onSelected: (_) => context
                                              .read<SearchFilterBloc>()
                                              .add(
                                                RentalObjectSelected(
                                                  objData.id,
                                                ),
                                              ),
                                          selected: isObjExisted,
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Địa điểm gần đó',
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<SearchFilterBloc, SearchFilterState>(
                      builder: (context, state) {
                        final nearbyPlaces = state.nearbyPlacesData;
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            child: Wrap(
                              spacing: 8,
                              runAlignment: WrapAlignment.spaceEvenly,
                              children: nearbyPlaces
                                  .map<Builder>(
                                    (placeData) => Builder(
                                      builder: (context) {
                                        final selectedPlaces = context
                                            .watch<SearchFilterBloc>()
                                            .state
                                            .selectedNearbyPlaces;
                                        final isPlaceExisted =
                                            selectedPlaces.any(
                                          (place) => place == placeData.id,
                                        );
                                        return FilterChip(
                                          label: Text(placeData.displayName),
                                          onSelected: (_) => context
                                              .read<SearchFilterBloc>()
                                              .add(
                                                NearbyPlaceSelected(
                                                  placeData.id,
                                                ),
                                              ),
                                          selected: isPlaceExisted,
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: FilledButton(
                        onPressed: () {
                          context
                              .read<SearchFilterBloc>()
                              .add(FilterSubmitted());
                          Navigator.of(context).pop();
                        },
                        child: const Text('Áp dụng bộ lọc'),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Builder(
                        builder: (context) {
                          final isInitialFilter = context
                              .watch<SearchFilterBloc>()
                              .state
                              .isInitialFilter;
                          return OutlinedButton(
                            onPressed: isInitialFilter
                                ? null
                                : () {
                                    context
                                        .read<SearchFilterBloc>()
                                        .add(RemoveSearchFilterPressed());
                                  },
                            child: const Text('Xóa bộ lọc'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchFilterBodyView extends StatelessWidget {
  const SearchFilterBodyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocBuilder<SearchFilterBloc, SearchFilterState>(
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
        return const SearchFilterListView();
      },
    );
  }
}

class SearchFilterListView extends StatefulWidget {
  const SearchFilterListView({super.key});

  @override
  State<SearchFilterListView> createState() => _SearchFilterListViewState();
}

class _SearchFilterListViewState extends State<SearchFilterListView> {
  late ScrollController _searchFilterScrollController;

  @override
  void initState() {
    super.initState();
    _searchFilterScrollController = ScrollController()
      ..addListener(() {
        if (_searchFilterScrollController.position.pixels >=
            _searchFilterScrollController.position.maxScrollExtent * 0.9) {
          EasyDebounce.debounce(
            'filter',
            const Duration(milliseconds: 300),
            () => context.read<SearchFilterBloc>().add(ScrollMoreReached()),
          );
        }
      });
  }

  @override
  void dispose() {
    _searchFilterScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final posts =
            context.select((SearchFilterBloc bloc) => bloc.state.posts);
        final loadingMoreStatus = context
            .select((SearchFilterBloc bloc) => bloc.state.loadingMoreStatus);
        return RefreshIndicator(
          onRefresh: ()async => context.read<SearchFilterBloc>().add(GetPosts()),
          child: ListView.separated(
            controller: _searchFilterScrollController,
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            itemCount: posts.length + 1,
            itemBuilder: (context, index) {
              if (index == posts.length) {
                if (loadingMoreStatus == LoadingStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
              }
              final post = posts[index];
              return PostListTileCard(post: post);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 8,
              );
            },
          ),
        );
      },
    );
  }
}
