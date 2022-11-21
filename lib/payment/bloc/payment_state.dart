part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  const PaymentState({
    this.bankCodes = const [],
    this.pageLoadingStatus = LoadingStatus.initial,
    this.currentCreditPage = 1,
    this.currentDebitPage = 1,
    this.creditHistoryList = const <CreditHistory>[],
    this.debitHistoryList = const <DebitHistory>[],
  });

  final List<BankCode> bankCodes;
  final List<CreditHistory> creditHistoryList;
  final List<DebitHistory> debitHistoryList;
  final LoadingStatus pageLoadingStatus;
  final int currentDebitPage;
  final int currentCreditPage;

  @override
  List<Object?> get props {
    return [
      bankCodes,
      creditHistoryList,
      debitHistoryList,
      pageLoadingStatus,
      currentDebitPage,
      currentCreditPage,
    ];
  }

  PaymentState copyWith({
    List<BankCode>? bankCodes,
    List<CreditHistory>? creditHistoryList,
    List<DebitHistory>? debitHistoryList,
    LoadingStatus? pageLoadingStatus,
    int? currentDebitPage,
    int? currentCreditPage,
  }) {
    return PaymentState(
      bankCodes: bankCodes ?? this.bankCodes,
      creditHistoryList: creditHistoryList ?? this.creditHistoryList,
      debitHistoryList: debitHistoryList ?? this.debitHistoryList,
      pageLoadingStatus: pageLoadingStatus ?? this.pageLoadingStatus,
      currentDebitPage: currentDebitPage ?? this.currentDebitPage,
      currentCreditPage: currentCreditPage ?? this.currentCreditPage,
    );
  }
}
