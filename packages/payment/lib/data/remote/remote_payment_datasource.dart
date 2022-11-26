import 'dart:developer';
import 'dart:io';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:payment/payment.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';

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

  @override
  Future<String> createPayment({
    required int amount,
    required String bankCode,
    required String desc,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      final responseData = await _httpHandler.post(
        ApiPath.payment,
        body: {
          'amount': amount,
          'bankCode': bankCode,
          'orderDesc': desc,
        },
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
      return responseData.data as String;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Future<>
}
