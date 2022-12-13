import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/search_filter/search_filter.dart';
import 'package:widgets/widgets.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return DismissFocus(
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
            const SheetDragHandle(),
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
