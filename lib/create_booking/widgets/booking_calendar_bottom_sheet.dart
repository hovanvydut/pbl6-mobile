import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/create_booking/create_booking.dart';
import 'package:widgets/widgets.dart';

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
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const CreateBookingCalendar(),
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
                const CreateBookingSelectedInfo(),
                const CreateBookingActionButtons()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
