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
}
