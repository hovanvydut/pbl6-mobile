import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:statistics/statistics.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc({required StatisticsRepository statisticsRepository})
      : _statisticsRepository = statisticsRepository,
        super(
          StatisticsState(
            fromDate: DateTime.now().subtract(const Duration(days: 10)),
            toDate: DateTime.now(),
          ),
        ) {
    on<PageStarted>(_onPageStarted);
    on<PostStatisticsTypeSelected>(_onTypeSelected);
    on<DateRangeSelected>(_onDateRangeSelected);
    on<ShowDetailStatisticsPressed>(_onDetailPressed);
    add(PageStarted());
  }

  final StatisticsRepository _statisticsRepository;

  Future<void> _onPageStarted(
    PageStarted event,
    Emitter<StatisticsState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final statisticsData =
          await _statisticsRepository.getPostStatisticsValuesByKey(
        state.currentKey,
        fromDate: state.fromDate,
        toDate: state.toDate,
      );
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.done,
          listStatisticsValue: statisticsData,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onTypeSelected(
    PostStatisticsTypeSelected event,
    Emitter<StatisticsState> emit,
  ) async {
    try {
      emit(
        state.copyWith(currentKey: event.key),
      );
      final statisticsData =
          await _statisticsRepository.getPostStatisticsValuesByKey(
        event.key,
        fromDate: state.fromDate,
        toDate: state.toDate,
      );
      emit(
        state.copyWith(
          listStatisticsValue: statisticsData,
          listStatisticsDetail: List.from([]),
          detailLoadingStatus: LoadingStatus.initial,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<FutureOr<void>> _onDetailPressed(
    ShowDetailStatisticsPressed event,
    Emitter<StatisticsState> emit,
  ) async {
    try {
      emit(state.copyWith(detailLoadingStatus: LoadingStatus.loading));
      final detailList =
          await _statisticsRepository.getDetailPostStatisticsDataByKey(
        state.currentKey,
        date: DateFormat('dd/MM/yyyy').parse(event.date),
      );
      emit(
        state.copyWith(
          detailLoadingStatus: LoadingStatus.done,
          listStatisticsDetail: detailList,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(detailLoadingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<FutureOr<void>> _onDateRangeSelected(
    DateRangeSelected event,
    Emitter<StatisticsState> emit,
  ) async {
    try {
      emit(state.copyWith(fromDate: event.fromDate, toDate: event.toDate));
      final statisticsData =
          await _statisticsRepository.getPostStatisticsValuesByKey(
        state.currentKey,
        fromDate: event.fromDate,
        toDate: event.toDate,
      );
      emit(
        state.copyWith(
          listStatisticsValue: statisticsData,
          listStatisticsDetail: List.from([]),
          detailLoadingStatus: LoadingStatus.initial,
        ),
      );
    } catch (e) {
      addError(e);
      rethrow;
    }
  }
}
