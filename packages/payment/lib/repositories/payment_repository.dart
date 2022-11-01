import 'package:payment/payment.dart';

class PaymentRepository {
  PaymentRepository({required IPaymentDatasource paymentDatasource})
      : _paymentDatasource = paymentDatasource;

  final IPaymentDatasource _paymentDatasource;
}
