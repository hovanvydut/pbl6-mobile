import 'package:models/models.dart';

abstract class IPaymentDatasource {
  Future<List<BankCode>> getBankCodes();
}
