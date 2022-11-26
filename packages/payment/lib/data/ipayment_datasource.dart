import 'package:models/models.dart';

abstract class IPaymentDatasource {
  Future<List<BankCode>> getBankCodes();

  Future<String> createPayment({
    required int amount,
    required String bankCode,
    required String desc,
  });

  Future<List<DebitHistory>> getPersonalDebitHistory({
    String? fromDate,
    String? toDate,
    int pageSize = 10,
    int pageNumber = 1,
    String? searchValue,
  });

  Future<List<CreditHistory>> getPersonalCreditHistory({
    String? fromDate,
    String? toDate,
    int pageSize = 10,
    int pageNumber = 1,
    String? searchValue,
  });
}
