import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/create_booking/create_booking.dart';
import 'package:pbl6_mobile/post/post.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:widgets/widgets.dart';

class CreateBookingPage extends StatelessWidget {
  const CreateBookingPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateBookingBloc(post: post),
      child: const CreateBookingView(),
    );
  }
}

class CreateBookingView extends StatelessWidget {
  const CreateBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissFocus(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Assets.icons.arrorLeft.svg(
              color: Theme.of(context).colorScheme.onSurface,
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
                        child: ListTile(
                          leading: Assets.icons.calendar2.svg(
                            height: 24,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          title: const Text('hehe'),
                          subtitle: const Text('hehe'),
                          trailing: Assets.icons.chevronRight.svg(
                            color: Theme.of(context).colorScheme.onSurface,
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
                                  value: context.read<CreateBookingBloc>(),
                                  child: const BookingCalendarBottomSheet(),
                                );
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
                          FilledButton(
                            onPressed: details.onStepContinue,
                            child: const Text('Tiếp tục'),
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
                  onStepTapped: (index) =>
                      context.read<CreateBookingBloc>().add(StepPressed(index)),
                  onStepContinue: () => context
                      .read<CreateBookingBloc>()
                      .add(StepPressed(state.currentStep + 1)),
                  onStepCancel: () => context
                      .read<CreateBookingBloc>()
                      .add(StepPressed(state.currentStep - 1)),
                );
              },
            )
          ],
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
    return Container(
      height: context.height * 0.75,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        // crossAxisAlignment:
        //     CrossAxisAlignment.stretch,
        children: [
          const SheetDragHandle(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                SizedBox(
                  height: context.height * 0.5,
                  child: SfCalendar(
                    view: CalendarView.week,
                  ),
                ),
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
