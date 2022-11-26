import 'package:booking/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/booking/booking.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/create_booking/create_booking.dart';
import 'package:pbl6_mobile/post/post.dart';
import 'package:platform_helper/platform_helper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:widgets/widgets.dart';

class CreateBookingPage extends StatelessWidget {
  const CreateBookingPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateBookingBloc(
        post: post,
        bookingRepository: context.read<BookingRepository>(),
      ),
      child: const CreateBookingView(),
    );
  }
}

class CreateBookingView extends StatelessWidget {
  const CreateBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateBookingBloc, CreateBookingState>(
      listenWhen: (previous, current) =>
          previous.formzStatus != current.formzStatus,
      listener: (context, state) {
        if (state.formzStatus.isSubmissionFailure) {
          ToastHelper.showToast('Tạo lịch xem trọ thất bại, vui lòng thử lại');
        }
        if (state.formzStatus.isSubmissionSuccess) {
          ToastHelper.showToast(
            'Đã tạo lịch xem trọ,\nchủ trọ sẽ xác nhận lịch của bạn',
          );
          context.pop();
        }
      },
      child: DismissFocus(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Assets.icons.arrorLeft.svg(
                color: context.colorScheme.onSurface,
                height: 32,
              ),
              onPressed: () => context.pop(),
            ),
            title: const Text(
              'Tạo lịch xem trọ',
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              BlocBuilder<CreateBookingBloc, CreateBookingState>(
                buildWhen: (previous, current) =>
                    previous.currentStep != current.currentStep,
                builder: (context, state) {
                  final currentStep = state.currentStep;
                  return Stepper(
                    currentStep: currentStep,
                    steps: [
                      Step(
                        title: const Text('Xác nhận thông tin'),
                        content: PostListTileCard(
                          post: state.post,
                          hideBookmark: true,
                          onCardTap: () => context.push(
                            AppRouter.detailPost,
                            extra: ExtraParams3<PostBloc, Post, BookmarkBloc?>(
                              param1: context.read<PostBloc>(),
                              param2: state.post,
                              param3: context.read<BookmarkBloc>(),
                            ),
                          ),
                        ),
                      ),
                      const Step(
                        title: Text('Xác nhận số điện thoại'),
                        content: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: BookingPhoneNumberField(),
                        ),
                      ),
                      Step(
                        title: const Text('Chọn lịch xem trọ'),
                        content: ListTileTheme(
                          data: const ListTileThemeData(
                            minLeadingWidth: 24,
                            contentPadding: EdgeInsets.zero,
                          ),
                          child: Builder(
                            builder: (context) {
                              final selectedTime = context.select(
                                (CreateBookingBloc bloc) =>
                                    bloc.state.selectedTime,
                              );
                              return ListTile(
                                leading: Assets.icons.calendar2.svg(
                                  height: 24,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                                title: selectedTime.isNotEmpty
                                    ? Text(
                                        selectedTime.first.start.yMdHm,
                                      )
                                    : const Text('Chọn thời gian xem trọ'),
                                trailing: Assets.icons.chevronRight.svg(
                                  color: context.colorScheme.onSurface,
                                ),
                                onTap: () {
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
                                        value:
                                            context.read<CreateBookingBloc>(),
                                        child:
                                            const BookingCalendarBottomSheet(),
                                      );
                                    },
                                  ).then((_) {
                                    final selectedTime = context
                                        .read<CreateBookingBloc>()
                                        .state
                                        .tempSelectedTime;
                                    if (selectedTime.isNotEmpty) {
                                      context
                                          .read<CreateBookingBloc>()
                                          .add(RemoveSchedulePressed());
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                    controlsBuilder: (context, details) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Builder(
                              builder: (context) {
                                final formStatus = context.select(
                                  (CreateBookingBloc bloc) =>
                                      bloc.state.formzStatus,
                                );

                                return formStatus.isSubmissionInProgress
                                    ? const CircularProgressIndicator()
                                    : FilledButton(
                                        onPressed: (formStatus.isPure ||
                                                formStatus.isInvalid)
                                            ? (details.currentStep == 0
                                                ? details.onStepContinue
                                                : null)
                                            : details.onStepContinue,
                                        child: const Text('Tiếp tục'),
                                      );
                              },
                            ),
                            const SizedBox(width: 16),
                            if (state.currentStep != 0)
                              TextButton(
                                onPressed: details.onStepCancel,
                                child: const Text('Quay lại'),
                              ),
                          ],
                        ),
                      );
                    },
                    onStepContinue: () {
                      if (state.currentStep == 2) {
                        context
                            .read<CreateBookingBloc>()
                            .add(CreateBookingSubmitted());
                        return;
                      }
                      context
                          .read<CreateBookingBloc>()
                          .add(StepPressed(state.currentStep + 1));
                    },
                    onStepCancel: () => context
                        .read<CreateBookingBloc>()
                        .add(StepPressed(state.currentStep - 1)),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BookingCalendarBottomSheet extends StatelessWidget {
  const BookingCalendarBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      height: context.height * 0.8,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const SheetDragHandle(),
          Padding(
            padding: const EdgeInsets.all(8) +
                const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '*Lưu ý: Lịch rảnh của chủ trọ chỉ mang tính chất tham khảo',
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(
                  height: context.height * 0.5,
                  child: BlocBuilder<CreateBookingBloc, CreateBookingState>(
                    buildWhen: (previous, current) =>
                        previous.freetimes != current.freetimes,
                    builder: (context, state) {
                      final freetimes = state.freetimes;
                      return SfCalendar(
                        view: CalendarView.week,
                        dataSource: FreetimeCalendarSource(freetimes),
                        timeSlotViewSettings: const TimeSlotViewSettings(
                          timeIntervalHeight: 80,
                          startHour: 6,
                          endHour: 21,
                          timeFormat: 'hh:mm a',
                        ),
                        onTap: (calendarTapDetails) {
                          if (calendarTapDetails.date != null) {
                            final selectedDate = calendarTapDetails.date!;
                            final appointmentInfo = AppointmentInfo(
                              start: selectedDate,
                              end: selectedDate.add(const Duration(hours: 1)),
                            );
                            context.read<CreateBookingBloc>().add(
                                  SchedulePressed(appointmentInfo),
                                );
                          }
                        },
                        firstDayOfWeek: 1,
                        blackoutDates: [
                          DateTime.now()
                              .add(const Duration(days: 1))
                              .subtract(const Duration(hours: 3)),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Builder(
                  builder: (context) {
                    final tempSelectedTime = context.select(
                      (CreateBookingBloc bloc) => bloc.state.tempSelectedTime,
                    );
                    if (tempSelectedTime.isEmpty) {
                      return Text(
                        'Bạn chưa chọn khung giờ nào',
                        style: theme.textTheme.titleMedium,
                      );
                    }
                    return Text(
                      'Bạn đã chọn khung giờ',
                      style: theme.textTheme.titleMedium,
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    final tempSelectedTime = context.select(
                      (CreateBookingBloc bloc) => bloc.state.tempSelectedTime,
                    );
                    if (tempSelectedTime.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListTileTheme(
                          data: const ListTileThemeData(
                            contentPadding: EdgeInsets.zero,
                          ),
                          child: ListTile(
                            leading: Assets.icons.clock.svg(
                              height: 24,
                              color: context.colorScheme.onSurface,
                            ),
                            title: const Text(
                              'Không có thông tin',
                            ),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListTileTheme(
                        data: const ListTileThemeData(
                          contentPadding: EdgeInsets.zero,
                        ),
                        child: ListTile(
                          leading: Assets.icons.clock.svg(
                            height: 24,
                            color: context.colorScheme.onSurface,
                          ),
                          title: Text(
                            tempSelectedTime.first.start.yMdHm,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Builder(
                      builder: (context) {
                        final tempSelectedTime = context.select(
                          (CreateBookingBloc bloc) =>
                              bloc.state.tempSelectedTime,
                        );
                        return FilledButton(
                          onPressed: tempSelectedTime.isEmpty
                              ? null
                              : () {
                                  context
                                      .read<CreateBookingBloc>()
                                      .add(ConfirmSchedulePressed());
                                  Navigator.of(context).pop();
                                },
                          child: const Text('Xác nhận'),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    Builder(
                      builder: (context) {
                        final tempSelectedTime = context.select(
                          (CreateBookingBloc bloc) =>
                              bloc.state.tempSelectedTime,
                        );
                        return TextButton(
                          onPressed: tempSelectedTime.isEmpty
                              ? null
                              : () => context
                                  .read<CreateBookingBloc>()
                                  .add(RemoveSchedulePressed()),
                          child: const Text('Chọn lại'),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookingPhoneNumberField extends StatelessWidget {
  const BookingPhoneNumberField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateBookingBloc, CreateBookingState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        final phoneNumber = state.phoneNumber;
        return AppTextField(
          labelText: 'Số điện thoại',
          errorText:
              phoneNumber.invalid ? getErrorText(phoneNumber.error!) : null,
          onChanged: (phoneNumber) => context
              .read<CreateBookingBloc>()
              .add(BookingPhoneNumberChanged(phoneNumber)),
          keyboardType: TextInputType.phone,
        );
      },
    );
  }

  String getErrorText(PhoneNumberValidationError error) {
    switch (error) {
      case PhoneNumberValidationError.empty:
        return 'Số điện thoại không được để trống';
      case PhoneNumberValidationError.notValid:
        return 'Số điện thoại không đúng định dạng';
    }
  }
}
