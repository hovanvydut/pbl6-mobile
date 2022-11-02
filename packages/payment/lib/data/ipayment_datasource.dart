import 'package:models/models.dart';

abstract class IPaymentDatasource {
  Future<List<BankCode>> getBankCodes();

  Future<String> createPayment({
    required int amount,
    required String bankCode,
    required String desc,
  });
}
