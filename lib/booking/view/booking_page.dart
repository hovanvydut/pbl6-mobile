import 'package:booking/booking.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/booking/booking.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:widgets/widgets.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc(
        bookingRepository: context.read<BookingRepository>(),
        user: context.read<AuthenticationBloc>().state.user!,
      ),
      child: const BookingView(),
    );
  }
}

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Assets.icons.arrorLeft.svg(
            color: theme.colorScheme.onSurface,
            height: 32,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Lịch xem trọ',
        ),
        centerTitle: true,
        actions: [
          PermissionWrapper(
            permission: Permission.freeTimeViewAll,
            child: IconButton(
              icon: Assets.icons.setting.svg(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              tooltip: 'Chỉnh sửa lịch rảnh',
              onPressed: () => context.pushToChild(
                AppRouter.configFreetime,
                extra: context.read<BookingBloc>(),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          final pageLoadingStatus = state.pageLoadingStatus;
          if (pageLoadingStatus == LoadingStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (pageLoadingStatus == LoadingStatus.error) {
            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  Assets.images.errorNotFound.svg(
                    height: 200,
                    width: 300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Đã có lỗi xảy ra, xin thử lại',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8),
            child: SfCalendar(
              view: CalendarView.week,
              timeSlotViewSettings: const TimeSlotViewSettings(
                timeIntervalHeight: 100,
                timeIntervalWidth: 60,
                startHour: 6,
                endHour: 22,
              ),
              dataSource: AppointmentCalendarDatasource(
                state.appointments,
                context: context,
              ),
              firstDayOfWeek: 1,
              showNavigationArrow: true,
              onTap: (calendarTapDetails) {
                if (calendarTapDetails.appointments == null) {
                  return;
                }
                final detail =
                    calendarTapDetails.appointments!.first as AppointmentInfo;
                if (detail.bookingData != null) {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: theme.colorScheme.surface,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (_) {
                      return BlocProvider.value(
                        value: context.read<BookingBloc>(),
                        child: DetailBookingSheet(detail: detail),
                      );
                    },
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailBookingSheet extends StatelessWidget {
  const DetailBookingSheet({
    super.key,
    required this.detail,
  });

  final AppointmentInfo detail;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return MultiBlocListener(
      listeners: [
        BlocListener<BookingBloc, BookingState>(
          listenWhen: (previous, current) =>
              previous.confirmMeetingStatus != current.confirmMeetingStatus,
          listener: (context, state) {
            if (state.confirmMeetingStatus == LoadingStatus.done) {
              ToastHelper.showToast('Đã xác nhận thành công');
              Navigator.pop(context);
            }
            if (state.confirmMeetingStatus == LoadingStatus.error) {
              ToastHelper.showToast('Xác nhận không thành công, xin thử lại');
            }
          },
        ),
        BlocListener<BookingBloc, BookingState>(
          listenWhen: (previous, current) =>
              previous.approveStatus != current.approveStatus,
          listener: (context, state) {
            if (state.approveStatus == LoadingStatus.done) {
              ToastHelper.showToast('Đã duyệt lịch xem trọ');
              Navigator.pop(context);
            }
            if (state.approveStatus == LoadingStatus.error) {
              ToastHelper.showToast('Duyệt không thành công, xin thử lại');
            }
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8) +
            const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: SheetDragHandle(),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Thông tin đặt lịch',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListTileTheme(
                    data: const ListTileThemeData(
                      contentPadding: EdgeInsets.zero,
                    ),
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: detail.bookingData?.guestInfo.avatar ??
                            'https://avatars.githubusercontent.com/u/63831488?v=4',
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 32,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) => CircleAvatar(
                          radius: 32,
                          backgroundColor: theme.colorScheme.surface,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.5,
                          ),
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          radius: 32,
                          backgroundColor: theme.colorScheme.surface,
                          child: Assets.icons.danger.svg(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      title: Text(
                        detail.bookingData!.guestInfo.displayName,
                      ),
                      subtitle: Text(
                        detail.bookingData?.guestInfo.phoneNumber ?? '',
                      ),
                    ),
                  ),
                  ListTileTheme(
                    data: const ListTileThemeData(
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.transparent,
                        child: Assets.icons.clock.svg(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      title: Text(
                        detail.start.yMd,
                      ),
                      subtitle: Text(
                        '${detail.start.Hm} - ${detail.end.Hm}',
                      ),
                    ),
                  ),
                  ListTileTheme(
                    data: const ListTileThemeData(
                      contentPadding: EdgeInsets.zero,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.transparent,
                        child: Assets.icons.tickCircle.svg(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      title: const Text('Trạng thái'),
                      subtitle: Text(
                        detail.bookingData!.approveTime != null
                            ? (detail.bookingData!.isMeet
                                ? 'Đã tới xem trọ'
                                : 'Đã chấp nhận lịch xem trọ')
                            : 'Chưa duyệt lịch xem trọ này',
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (detail.bookingData!.approveTime != null)
                    if (!detail.bookingData!.isMeet)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                            child: const Text('Đã xem trọ'),
                            onPressed: () => context.read<BookingBloc>().add(
                                  ConfirmMeetingPressed(detail.bookingData!.id),
                                ),
                          ),
                          const SizedBox(width: 24),
                          TextButton(
                            child: const Text('Chưa tới xem trọ'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      )
                    else
                      const SizedBox()
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          child: const Text('Duyệt lịch'),
                          onPressed: () => context
                              .read<BookingBloc>()
                              .add(ApprovePressed(detail.bookingData!.id)),
                        ),
                        const SizedBox(width: 24),
                        TextButton(
                          child: const Text('Từ chối'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
