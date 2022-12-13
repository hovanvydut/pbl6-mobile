import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/create_booking/create_booking.dart';
import 'package:widgets/widgets.dart';

class CreateBookingActionButtons extends StatelessWidget {
  const CreateBookingActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(
          builder: (context) {
            final tempSelectedTime = context.select(
              (CreateBookingBloc bloc) => bloc.state.tempSelectedTime,
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
              (CreateBookingBloc bloc) => bloc.state.tempSelectedTime,
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
    );
  }
}
