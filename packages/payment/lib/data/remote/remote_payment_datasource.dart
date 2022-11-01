import 'package:http_client_handler/http_client_handler.dart';
import 'package:payment/payment.dart';

class RemotePaymentDatasource implements IPaymentDatasource {
  RemotePaymentDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;
}
