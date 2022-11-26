part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  const PaymentState({this.bankCodes = const []});

  final List<BankCode> bankCodes;
  @override
  List<Object?> get props => [bankCodes];

  PaymentState copyWith({
    List<BankCode>? bankCodes,
  }) {
    return PaymentState(
      bankCodes: bankCodes ?? this.bankCodes,
    );
  }
}
