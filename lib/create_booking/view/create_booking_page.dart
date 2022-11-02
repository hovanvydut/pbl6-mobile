import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pbl6_mobile/create_booking/create_booking.dart';

class CreateBookingPage extends StatelessWidget {
  const CreateBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateBookingBloc(),
      child: const CreateBookingView(),
    );
  }
}

class CreateBookingView extends StatelessWidget {
  const CreateBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('CreateBookingView is working'),
      ),
    );
  }
}
