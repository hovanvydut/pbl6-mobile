part of 'create_payment_bloc.dart';

class CreatePaymentState extends Equatable {
  const CreatePaymentState({
    this.amount = 0,
    this.selectedBankCode = '',
    this.description = '',
    this.bankCodes = const [],
    this.urlRepsonse = '',
    this.loadingDataStatus = LoadingStatus.initial,
    this.createPaymentStatus = LoadingStatus.initial,
  });

  final int amount;
  final String selectedBankCode;
  final String description;
  final List<BankCode> bankCodes;
  final String urlRepsonse;
  final LoadingStatus loadingDataStatus;
  final LoadingStatus createPaymentStatus;

  @override
  List<Object> get props {
    return [
      amount,
      selectedBankCode,
      description,
      bankCodes,
      urlRepsonse,
      loadingDataStatus,
      createPaymentStatus,
    ];
  }

  CreatePaymentState copyWith({
    int? amount,
    String? selectedBankCode,
    String? description,
    List<BankCode>? bankCodes,
    String? urlRepsonse,
    LoadingStatus? loadingDataStatus,
    LoadingStatus? createPaymentStatus,
  }) {
    return CreatePaymentState(
      amount: amount ?? this.amount,
      selectedBankCode: selectedBankCode ?? this.selectedBankCode,
      description: description ?? this.description,
      bankCodes: bankCodes ?? this.bankCodes,
      urlRepsonse: urlRepsonse ?? this.urlRepsonse,
      loadingDataStatus: loadingDataStatus ?? this.loadingDataStatus,
      createPaymentStatus: createPaymentStatus ?? this.createPaymentStatus,
    );
  }
}
