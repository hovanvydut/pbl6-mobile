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
      log(e.toString(), name: runtimeType.toString());

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
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }

  @override
  Future<List<CreditHistory>> getPersonalCreditHistory({
    String? fromDate,
    String? toDate,
    int pageSize = 10,
    int pageNumber = 1,
    String? searchValue,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      final responseData = await _httpHandler.get(
        ApiPath.personalCreditHistory,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
        queryParameter: Map.fromEntries(
          {
            'FromDate': fromDate,
            'ToDate': toDate,
            'PageNumber': '$pageNumber',
            'PageSize': '$pageSize',
            'searchValue': searchValue
          }.entries.toList()
            ..removeWhere((entry) => entry.value == null),
        ),
      );
      final data =
          (responseData.data as Map<String, dynamic>)['records'] as List;
      return data
          .map(
            (e) => CreditHistory.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }

  @override
  Future<List<DebitHistory>> getPersonalDebitHistory({
    String? fromDate,
    String? toDate,
    int pageSize = 10,
    int pageNumber = 1,
    String? searchValue,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      final responseData = await _httpHandler.get(
        ApiPath.personalDebitHistory,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
        queryParameter: Map.fromEntries(
          {
            'FromDate': fromDate,
            'ToDate': toDate,
            'PageNumber': '$pageNumber',
            'PageSize': '$pageSize',
            'searchValue': searchValue
          }.entries.toList()
            ..removeWhere((entry) => entry.value == null),
        ),
      );
      final data =
          (responseData.data as Map<String, dynamic>)['records'] as List;
      return data
          .map(
            (e) => DebitHistory.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }

}
