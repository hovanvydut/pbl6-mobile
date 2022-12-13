import 'dart:developer';
import 'dart:io';

import 'package:booking/booking.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';

class RemoteBookingDatasource implements IBookingDatasource {
  RemoteBookingDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<void> approveBooking({required int bookingId}) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.put(
        ApiPath.approveBooking(bookingId),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
    } catch (e) {
      log(e.toString(), name: 'REMOTE_BOOKING_DATASOURCE');
      rethrow;
    }
  }

  @override
  Future<void> confirmMeeting({required int bookingId}) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.put(
        ApiPath.confirmMeeting(bookingId),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
    } catch (e) {
      log(e.toString(), name: 'REMOTE_BOOKING_DATASOURCE');
      rethrow;
    }
  }

  @override
  Future<void> createBooking({
    required int postId,
    required DateTime bookingTime,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.post(
        ApiPath.booking,
        body: {
          'postId': postId,
          'time': bookingTime.toUtc().toIso8601String(),
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      );
    } catch (e) {
      log(e.toString(), name: 'REMOTE_BOOKING_DATASOURCE');
      rethrow;
    }
  }

  @override
  Future<List<BookingData>> getBookingList({
    int? month,
    int? year,
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      final responseData = await _httpHandler.get(
        ApiPath.bookingPersonal,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
        queryParameter: Map.fromEntries(
          {
            'month': month != null ? '$month' : null,
            'year': year != null ? '$year' : null,
            'PageNumber': '$pageNumber',
            'PageSize': '$pageSize',
            'SearchValue': searchValue,
          }.entries.toList()
            ..removeWhere((entry) => entry.value == null),
        ),
      );
      final data = responseData.data as Map<String, dynamic>;
      final bookingData = data['records'] as List;
      return bookingData
          .map((data) => BookingData.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString(), name: 'REMOTE_BOOKING_DATASOURCE');
      rethrow;
    }
  }

  @override
  Future<List<Freetime>> getFreeTimeByUserId(int userId) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      final responseData = await _httpHandler.get(
        ApiPath.freetimeOther(userId),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
      final freetimeData = responseData.data as List;
      return freetimeData
          .map<Freetime>(
            (data) => Freetime.fromJson(data as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      log(e.toString(), name: 'REMOTE_BOOKING_DATASOURCE');
      rethrow;
    }
  }

  @override
  Future<void> setFreetime({required List<Freetime> freetimes}) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.post(
        ApiPath.freetime,
        body: {
          'data': freetimes
              .map(
                (freetime) => freetime.toJson(),
              )
              .toList(),
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      );
    } catch (e) {
      log(e.toString(), name: 'REMOTE_BOOKING_DATASOURCE');
      rethrow;
    }
  }
}
