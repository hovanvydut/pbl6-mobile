import 'package:booking/booking.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';

part 'config_freetime_state.dart';

class ConfigFreetimeCubit extends Cubit<ConfigFreetimeState> {
  ConfigFreetimeCubit({
    required User user,
    required List<Freetime> freetimes,
    required BookingRepository bookingRepository,
  })  : _bookingRepository = bookingRepository,
        super(ConfigFreetimeState(user: user, freetimes: freetimes));

  final BookingRepository _bookingRepository;

  void allowEditing() {
    emit(state.copyWith(isEditing: true));
  }

  void addFreetimes(DateTime dateTime) {
    if (state.isEditing) {
      final isSelected = state.freetimes
          .any((freetime) => freetime.start.toDateTime == dateTime);
      if (!isSelected) {
        emit(
          state.copyWith(
            freetimes: [
              ...state.freetimes,
              Freetime(
                day: dateTime.dayOfWeek,
                start: dateTime.toIso8601String(),
                end: dateTime.add(const Duration(hours: 1)).toIso8601String(),
              )
            ],
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          freetimes: state.freetimes
              .where((freetime) => freetime.start != dateTime.toIso8601String())
              .toList(),
        ),
      );
    }
  }

  Future<void> saveFreetimes() async {
    try {
      emit(state.copyWith(saveLoadingStatus: LoadingStatus.loading));
      await _bookingRepository.setFreeTime(freetimes: state.freetimes);
      emit(state.copyWith(saveLoadingStatus: LoadingStatus.done));
    } catch (e) {
      addError(e);
      emit(state.copyWith(saveLoadingStatus: LoadingStatus.error));
      rethrow;
    }
  }
}
