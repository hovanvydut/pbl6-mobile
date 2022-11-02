import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/booking/booking.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc(),
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
          'Lịch đã đặt',
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('BookingView is working'),
      ),
    );
  }
}