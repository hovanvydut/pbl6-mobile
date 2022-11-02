part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class PaymentPageStarted extends PaymentEvent {}

class GetPaymentHistory extends PaymentEvent {}
