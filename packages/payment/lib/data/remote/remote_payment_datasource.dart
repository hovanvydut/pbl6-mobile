import 'dart:developer';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:payment/payment.dart';

class RemotePaymentDatasource implements IPaymentDatasource {
  RemotePaymentDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<List<BankCode>> getBankCodes() async {
    try {
      final responseData = await _httpHandler.get(ApiPath.paymentBankCode);

      final bankCodesData = responseData.data as List;
      return bankCodesData
          .map((data) => BankCode.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
