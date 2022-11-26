part of 'statistics_bloc.dart';

class StatisticsState extends Equatable {
  const StatisticsState({
    this.loadingStatus = LoadingStatus.initial,
    this.detailLoadingStatus = LoadingStatus.initial,
    this.listStatisticsValue = const <StatisticsValue>[],
    this.listStatisticsDetail = const <StatisticsData>[],
    this.currentKey = StatisticsKey.viewPostDetail,
    this.statisticsKeys = const [
      StatisticsKey.viewPostDetail,
      StatisticsKey.booking,
      StatisticsKey.bookmark,
      StatisticsKey.guestMet,
    ],
    required this.fromDate,
    required this.toDate,
  });

  final LoadingStatus loadingStatus;
  final LoadingStatus detailLoadingStatus;
  final List<StatisticsValue> listStatisticsValue;
  final List<StatisticsData> listStatisticsDetail;
  final String currentKey;
  final List<String> statisticsKeys;
  final DateTime fromDate;
  final DateTime toDate;

  @override
  List<Object> get props {
    return [
      loadingStatus,
      detailLoadingStatus,
      listStatisticsValue,
      listStatisticsDetail,
      currentKey,
      statisticsKeys,
      fromDate,
      toDate,
    ];
  }

  StatisticsState copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? detailLoadingStatus,
    List<StatisticsValue>? listStatisticsValue,
    List<StatisticsData>? listStatisticsDetail,
    String? currentKey,
    List<String>? statisticsKeys,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return StatisticsState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      detailLoadingStatus: detailLoadingStatus ?? this.detailLoadingStatus,
      listStatisticsValue: listStatisticsValue ?? this.listStatisticsValue,
      listStatisticsDetail: listStatisticsDetail ?? this.listStatisticsDetail,
      currentKey: currentKey ?? this.currentKey,
      statisticsKeys: statisticsKeys ?? this.statisticsKeys,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }
}
