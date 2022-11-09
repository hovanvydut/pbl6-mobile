import 'dart:developer';

import 'package:booking/booking.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/booking/booking.dart';

part 'config_freetime_state.dart';

class ConfigFreetimeCubit extends Cubit<ConfigFreetimeState> {
  ConfigFreetimeCubit({
    required User user,
    required List<AppointmentInfo> freetimes,
    required BookingRepository bookingRepository,
  })  : _bookingRepository = bookingRepository,
        super(ConfigFreetimeState(user: user, freetimes: freetimes));

  final BookingRepository _bookingRepository;

  void allowEditing() {
    emit(state.copyWith(isEditing: true));
  }

  void addFreetimes(DateTime dateTime) {
    if (state.isEditing) {
      final isSelected = state.freetimes.any((freetime) {
        return freetime.start == dateTime;
      });
      if (!isSelected) {
        emit(
          state.copyWith(
            freetimes: [
              ...state.freetimes,
              AppointmentInfo(
                start: dateTime,
                end: dateTime.add(const Duration(hours: 1)),
              )
            ],
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          freetimes: state.freetimes
              .where((freetime) => freetime.start != dateTime)
              .toList(),
        ),
      );
    }
  }

  Future<void> saveFreetimes() async {
    try {
      emit(state.copyWith(saveLoadingStatus: LoadingStatus.loading));
      final freetimesWeekly = state.freetimes
          .map(
            (freetime) => Freetime(
              day: freetime.start.dayOfWeek - 1,
              start: freetime.start.hour.toString(),
              end: freetime.end.hour.toString(),
            ),
          )
          .toList();
      log(freetimesWeekly.toString());
      await _bookingRepository.setFreeTime(freetimes: freetimesWeekly);
      emit(state.copyWith(saveLoadingStatus: LoadingStatus.done));
    } catch (e) {
      addError(e);
      emit(state.copyWith(saveLoadingStatus: LoadingStatus.error));
      rethrow;
    }
  }
}
