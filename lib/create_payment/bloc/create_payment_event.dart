part of 'create_payment_bloc.dart';

abstract class CreatePaymentEvent extends Equatable {
  const CreatePaymentEvent();

  @override
  List<Object?> get props => [];
}

class CreatePaymentPageStarted extends CreatePaymentEvent {}

class AmountChanged extends CreatePaymentEvent {
  const AmountChanged(this.amount);
  final String amount;

  @override
  List<Object?> get props => [amount];
}

class BankCodeChanged extends CreatePaymentEvent {
  const BankCodeChanged(this.bankCode);
  final String bankCode;

  @override
  List<Object?> get props => [bankCode];
}

class OrderDescriptionChanged extends CreatePaymentEvent {
  const OrderDescriptionChanged(this.desc);
  final String desc;

  @override
  List<Object?> get props => [desc];
}

class CreatePaymentSumitted extends CreatePaymentEvent {}
