import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/create_payment/create_payment.dart';


class CreatePaymentPage extends StatelessWidget {
  const CreatePaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePaymentBloc(),
      child: const CreatePaymentView(),
    );
  }
}

class CreatePaymentView extends StatelessWidget {
  const CreatePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('CreatePaymentView is working'),
      ),
    );
  }
}
