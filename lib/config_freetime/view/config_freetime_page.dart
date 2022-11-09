import 'package:booking/booking.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/booking/booking.dart';
import 'package:pbl6_mobile/config_freetime/config_freetime.dart';
import 'package:pbl6_mobile/create_booking/create_booking.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ConfigFreetimePage extends StatelessWidget {
  const ConfigFreetimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfigFreetimeCubit(
        user: context.read<AuthenticationBloc>().state.user!,
        bookingRepository: context.read<BookingRepository>(),
        freetimes: context
            .read<BookingBloc>()
            .state
            .appointments
            .where((appointment) => appointment.bookingData == null)
            .toList(),
      ),
      child: const ConfigFreetimeView(),
    );
  }
}

class ConfigFreetimeView extends StatelessWidget {
  const ConfigFreetimeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocListener<ConfigFreetimeCubit, ConfigFreetimeState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing ||
          previous.saveLoadingStatus != current.saveLoadingStatus,
      listener: (context, state) {
        if (state.isEditing) {
          context.showSnackBar(message: 'Bạn đang ở chế độ chỉnh sửa');
        }
        if (state.saveLoadingStatus == LoadingStatus.loading) {
          context.showSnackBar(message: 'Đang cập nhật thời gian rảnh');
        }
        if (state.saveLoadingStatus == LoadingStatus.done) {
          context
            ..showSnackBar(message: 'Cập nhật thành công')
            ..pop();
          context.read<BookingBloc>().add(EditUpdatedFreetime(state.freetimes));
        }
        if (state.saveLoadingStatus == LoadingStatus.error) {
          context.showSnackBar(message: 'Cập nhật thật bại, vui lòng thử lại');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Assets.icons.arrorLeft.svg(
              color: theme.colorScheme.onSurface,
              height: 32,
            ),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'Chỉnh sửa lịch rảnh',
          ),
          centerTitle: true,
          actions: const [
            ConfigFreetimeActionButton(),
          ],
        ),
        body: BlocBuilder<ConfigFreetimeCubit, ConfigFreetimeState>(
          buildWhen: (previous, current) =>
              previous.freetimes != current.freetimes,
          builder: (context, state) {
            final freetimes = state.freetimes;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: SfCalendar(
                view: CalendarView.week,
                minDate: DateTimeHelper.firstDateOfWeek,
                maxDate: DateTimeHelper.lastDateOfWeek,
                dataSource: FreetimeCalendarSource(freetimes),
                firstDayOfWeek: 1,
                timeSlotViewSettings: const TimeSlotViewSettings(
                  timeIntervalHeight: 100,
                  timeIntervalWidth: 60,
                  startHour: 6,
                  endHour: 22,
                ),
                onTap: (calendarTapDetails) {
                  context
                      .read<ConfigFreetimeCubit>()
                      .addFreetimes(calendarTapDetails.date!);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ConfigFreetimeActionButton extends StatelessWidget {
  const ConfigFreetimeActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isEditing = context.watch<ConfigFreetimeCubit>().state.isEditing;
        return isEditing
            ? IconButton(
                icon: Assets.icons.save.svg(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                tooltip: 'Lưu lịch rảnh',
                onPressed: () =>
                    context.read<ConfigFreetimeCubit>().saveFreetimes(),
              )
            : IconButton(
                icon: Assets.icons.edit.svg(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                tooltip: 'Chỉnh sửa lịch rảnh',
                onPressed: () =>
                    context.read<ConfigFreetimeCubit>().allowEditing(),
              );
      },
    );
  }
}
