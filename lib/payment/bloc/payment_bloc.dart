import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<PaymentPageStarted>(_onPaymentPageStarted);
    on<GetPaymentHistory>(_onGetPaymentHistory);
  }

  void _onGetPaymentHistory(
    GetPaymentHistory event,
    Emitter<PaymentState> emit,
  ) {}

  void _onPaymentPageStarted(
    PaymentPageStarted event,
    Emitter<PaymentState> emit,
  ) {}
}
