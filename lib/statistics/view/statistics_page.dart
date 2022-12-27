import 'package:constant_helper/constant_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/statistics/statistics.dart';
import 'package:statistics/statistics.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:widgets/widgets.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisticsBloc(
        statisticsRepository: context.read<StatisticsRepository>(),
      ),
      child: const StatisticsView(),
    );
  }
}

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Assets.icons.arrorLeft.svg(
            color: context.colorScheme.onSurface,
            height: 32,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text('Thống kê'),
        centerTitle: true,
      ),
      body: BlocBuilder<StatisticsBloc, StatisticsState>(
        builder: (context, state) {
          final loadingStatus = state.loadingStatus;
          if (loadingStatus == LoadingStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (loadingStatus == LoadingStatus.error) {
            return const Center(
              child: Text('error'),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                StatisticsTypeDropDown(),
                SizedBox(height: 8),
                DateRangeTextField(),
                SizedBox(height: 8),
                CounterDataText(),
                SizedBox(height: 8),
                StatisticsChart(),
                SizedBox(height: 8),
                DetailStatisticsPanel()
              ],
            ),
          );
        },
      ),
    );
  }
}

class CounterDataText extends StatelessWidget {
  const CounterDataText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final values = context.select(
          (StatisticsBloc bloc) => bloc.state.listStatisticsValue,
        );
        final sum = values.fold<int>(
          0,
          (previous, value) => previous + value.value,
        );
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Tổng: $sum lượt',
            style: context.textTheme.titleLarge
                ?.copyWith(color: context.colorScheme.onSurface),
          ),
        );
      },
    );
  }
}

class DetailStatisticsPanel extends StatelessWidget {
  const DetailStatisticsPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Thống kê chi tiết',
            style: context.textTheme.titleLarge!
                .copyWith(color: context.colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Builder(
            builder: (context) {
              final listStatisticsDetail = context.select(
                (StatisticsBloc bloc) => bloc.state.listStatisticsDetail,
              );
              final detailLoadingStatus = context.select(
                (StatisticsBloc bloc) => bloc.state.detailLoadingStatus,
              );
              if (detailLoadingStatus == LoadingStatus.initial) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text(
                      'Hãy chọn vào một giá trị bất kỳ để hiển thị chi tiết',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              }
              if (detailLoadingStatus == LoadingStatus.loading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (detailLoadingStatus == LoadingStatus.error) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text(
                      'Đã có lỗi xảy ra, vui lòng thử lại',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              }
              if (listStatisticsDetail.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text(
                      'Không có dữ liệu chi tiết',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              }
              return ListView.separated(
                itemCount: listStatisticsDetail.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  final detail = listStatisticsDetail[index];
                  return ListTile(
                    title: Text(detail.title),
                    trailing: Text(
                      '${detail.statisticValue}',
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class StatisticsChart extends StatelessWidget {
  const StatisticsChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentKey =
        context.select((StatisticsBloc bloc) => bloc.state.currentKey);
    final statData =
        context.select((StatisticsBloc bloc) => bloc.state.listStatisticsValue);
    return SizedBox(
      height: context.height * 0.4,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          minimum: 0,
          interval: 2,
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<StatisticsValue, String>>[
          ColumnSeries<StatisticsValue, String>(
            dataSource: statData,
            xValueMapper: (StatisticsValue data, _) => data.date,
            yValueMapper: (StatisticsValue data, _) => data.value,
            name: StatisticsMapper.mapFrom(currentKey),
            color: context.colorScheme.primary,
            width: 1,
            spacing: 0.1,
            yAxisName: StatisticsMapper.mapFrom(currentKey),
            xAxisName: 'Ngày',
            onPointTap: (pointInteractionDetails) {
              final dataPoints = pointInteractionDetails.dataPoints
                  as List<CartesianChartPoint>?;
              if (dataPoints != null) {
                final pointIndex = pointInteractionDetails.pointIndex!;
                context.read<StatisticsBloc>().add(
                      ShowDetailStatisticsPressed(
                        dataPoints[pointIndex].x.toString(),
                      ),
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}

class DateRangeTextField extends StatefulWidget {
  const DateRangeTextField({
    super.key,
  });

  @override
  State<DateRangeTextField> createState() => _DateRangeTextFieldState();
}

class _DateRangeTextFieldState extends State<DateRangeTextField> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    final tenDayAgo = DateTime.now().subtract(const Duration(days: 10));
    final now = DateTime.now();
    _textEditingController = TextEditingController()
      ..text = '${tenDayAgo.yMd} - ${now.yMd}';
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AppTextField(
        textEditingController: _textEditingController,
        labelText: 'Khoảng thời gian',
        readOnly: true,
        suffixIcon: IconButton(
          icon: Assets.icons.calendar2.svg(),
          onPressed: () {
            final now = DateTime.now();
            final fromDate = context.read<StatisticsBloc>().state.fromDate;
            final toDate = context.read<StatisticsBloc>().state.toDate;

            showDateRangePicker(
              context: context,
              firstDate: DateTime(now.year - 1),
              lastDate: DateTime(now.year + 1),
              currentDate: now,
              initialDateRange: DateTimeRange(
                start: fromDate,
                end: toDate,
              ),
            ).then((range) {
              if (range != null) {
                context.read<StatisticsBloc>().add(
                      DateRangeSelected(
                        fromDate: range.start,
                        toDate: range.end,
                      ),
                    );
                _textEditingController.text =
                    '${range.start.yMd} - ${range.end.yMd}';
              }
            });
          },
        ),
      ),
    );
  }
}

class StatisticsTypeDropDown extends StatelessWidget {
  const StatisticsTypeDropDown({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final statisticsKeys =
        context.select((StatisticsBloc bloc) => bloc.state.statisticsKeys);
    final currentKey =
        context.select((StatisticsBloc bloc) => bloc.state.currentKey);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AppDropDownField<String>(
        labelText: 'Dữ liệu',
        items: statisticsKeys
            .map<DropdownMenuItem<String>>(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(StatisticsMapper.mapFrom(e)),
              ),
            )
            .toList(),
        value: currentKey,
        onChanged: (item) {
          if (item != null) {
            context
                .read<StatisticsBloc>()
                .add(PostStatisticsTypeSelected(item));
          }
        },
      ),
    );
  }
}
