import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/create_booking/create_booking.dart';

class CreateBookingSelectedInfo extends StatelessWidget {
  const CreateBookingSelectedInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
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
    );
  }
}
