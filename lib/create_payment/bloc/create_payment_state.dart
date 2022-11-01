part of 'create_payment_bloc.dart';

class CreatePaymentState extends Equatable {
  const CreatePaymentState({this.bankCodes = const []});

  final List<BankCode> bankCodes;
  @override
  List<Object?> get props => [bankCodes];

  CreatePaymentState copyWith({
    List<BankCode>? bankCodes,
  }) {
    return CreatePaymentState(
      bankCodes: bankCodes ?? this.bankCodes,
    );
  }
}
