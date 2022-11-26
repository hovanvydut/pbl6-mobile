import 'dart:async';

import 'package:config/config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:uptop/repositories/uptop_repository.dart';

part 'uptop_event.dart';
part 'uptop_state.dart';

class UptopBloc extends Bloc<UptopEvent, UptopState> {
  UptopBloc({
    required Post post,
    required UptopRepository uptopRepository,
    required ConfigRepository configRepository,
  })  : _uptopRepository = uptopRepository,
        _configRepository = configRepository,
        super(UptopState(post: post, startDate: DateTime.now())) {
    on<CreateDialogStarted>(_onCreateDialogStarted);
    on<NumOfDayChanged>(_onNumOfDayChanged);
    on<StartDateChanged>(_onStartedDateChanged);
    on<UptopSubmitted>(_onSubmitted);
    on<DetailDialogStarted>(_onDetailDialogStarted);
  }

  final UptopRepository _uptopRepository;
  final ConfigRepository _configRepository;

  Future<void> _onCreateDialogStarted(
    CreateDialogStarted event,
    Emitter<UptopState> emit,
  ) async {
    try {
      emit(state.copyWith(dialogLoadingStatus: LoadingStatus.loading));
      final uptopConfigData = await _configRepository.getConfigDataByKey(
        configKey: ConfigKey.uptopPrice,
      );
      emit(
        state.copyWith(
          dialogLoadingStatus: LoadingStatus.done,
          configPrice: uptopConfigData.value,
          totalPrice: uptopConfigData.value,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(dialogLoadingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  void _onNumOfDayChanged(
    NumOfDayChanged event,
    Emitter<UptopState> emit,
  ) {
    emit(
      state.copyWith(
        day: event.day,
        totalPrice: state.configPrice * event.day,
      ),
    );
  }

  void _onStartedDateChanged(
    StartDateChanged event,
    Emitter<UptopState> emit,
  ) {
    emit(state.copyWith(startDate: event.startDate));
  }

  Future<void> _onSubmitted(
    UptopSubmitted event,
    Emitter<UptopState> emit,
  ) async {
    try {
      emit(state.copyWith(uptopLoadingStatus: LoadingStatus.loading));
      await _uptopRepository.createUptopSession(
        days: state.day,
        postId: state.post.id,
        startTime: state.startDate,
      );
      emit(state.copyWith(uptopLoadingStatus: LoadingStatus.done));
    } catch (e) {
      addError(e);
      emit(state.copyWith(uptopLoadingStatus: LoadingStatus.error));
      rethrow;
    }
  }

  Future<void> _onDetailDialogStarted(
    DetailDialogStarted event,
    Emitter<UptopState> emit,
  ) async {
    try {
      emit(state.copyWith(dialogLoadingStatus: LoadingStatus.loading));
      final uptopPostData = await _uptopRepository.getUptopDataByPost(
        state.post.id,
      );
      await Future.delayed(Duration.zero);
      emit(
        state.copyWith(
          dialogLoadingStatus: LoadingStatus.done,
          uptopData: uptopPostData,
        ),
      );
    } catch (e) {
      addError(e);
      emit(state.copyWith(dialogLoadingStatus: LoadingStatus.error));
      rethrow;
    }
  }
}
