import 'package:booking/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/booking/booking.dart';
import 'package:pbl6_mobile/create_booking/create_booking.dart';
import 'package:platform_helper/platform_helper.dart';
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
          body: const CreateBookingStepper(),
        ),
      ),
    );
  }
}
