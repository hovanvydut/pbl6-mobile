import 'package:models/models.dart';
import 'package:payment/payment.dart';

class PaymentRepository {
  PaymentRepository({required IPaymentDatasource paymentDatasource})
      : _paymentDatasource = paymentDatasource;

  final IPaymentDatasource _paymentDatasource;

  Future<List<BankCode>> getBankCodes() => _paymentDatasource.getBankCodes();

  Future<String> createPayment({
    required int amount,
    required String bankCode,
    required String desc,
  }) =>
      _paymentDatasource.createPayment(
        amount: amount,
        bankCode: bankCode,
        desc: desc,
      );

  Future<List<DebitHistory>> getPersonalDebitHistory({
    String? fromDate,
    String? toDate,
    int pageSize = 10,
    int pageNumber = 1,
    String? searchValue,
  }) =>
      _paymentDatasource.getPersonalDebitHistory(
        fromDate: fromDate,
        pageNumber: pageNumber,
        pageSize: pageNumber,
        searchValue: searchValue,
        toDate: toDate,
      );

  Future<List<CreditHistory>> getPersonalCreditHistory({
    String? fromDate,
    String? toDate,
    int pageSize = 10,
    int pageNumber = 1,
    String? searchValue,
  }) =>
      _paymentDatasource.getPersonalCreditHistory(
        fromDate: fromDate,
        pageNumber: pageNumber,
        pageSize: pageSize,
        toDate: toDate,
        searchValue: searchValue,
      );
}
