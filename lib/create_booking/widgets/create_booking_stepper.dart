import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/create_booking/create_booking.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';
import 'package:widgets/widgets.dart';

class CreateBookingStepper extends StatelessWidget {
  const CreateBookingStepper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateBookingBloc, CreateBookingState>(
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
                  extra: ExtraParams3<UserPostBloc, Post, BookmarkBloc?>(
                    param1: context.read<UserPostBloc>(),
                    param2: state.post,
                    param3: context.read<BookmarkBloc>(),
                  ),
                ),
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
                      (CreateBookingBloc bloc) => bloc.state.selectedTime,
                    );
                    return ListTile(
                      leading: Assets.icons.calendar2.svg(
                        height: 24,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                              value: context.read<CreateBookingBloc>(),
                              child: const BookingCalendarBottomSheet(),
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
                        (CreateBookingBloc bloc) => bloc.state.formzStatus,
                      );

                      return formStatus.isSubmissionInProgress
                          ? const CircularProgressIndicator()
                          : FilledButton(
                              onPressed: details.onStepContinue,
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
            if (state.currentStep == 1) {
              context.read<CreateBookingBloc>().add(CreateBookingSubmitted());
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
    );
  }
}
