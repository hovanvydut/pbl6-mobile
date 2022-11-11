import 'dart:developer';
import 'dart:io';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:review/review.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';

class RemoteReviewDatasource implements IReviewDatasource {
  RemoteReviewDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<List<Review>> getReviewsByPostId(
    int postId, {
    int pageNumber = 1,
    int pageSize = 5,
    String? searchValue,
  }) async {
    try {
      final responseData = await _httpHandler.get(
        ApiPath.postReview(postId),
        queryParameter: Map.fromEntries(
          {
            'PageNumber': '$pageNumber',
            'PageSize': '$pageSize',
            'SearchValue': searchValue,
          }.entries.toList()
            ..removeWhere(
              (entry) => entry.value == null,
            ),
        ),
      );
      final data = responseData.data as Map<String, dynamic>;
      final reviewsData = data['records'] as List;
      return reviewsData
          .map((data) => Review.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString(), name: 'REMOTE_REVIEW_DATASOURCE');
      rethrow;
    }
  }

  @override
  Future<void> createReview({
    required int postId,
    required String content,
    required int rating,
    required List<Media> medias,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.post(
        ApiPath.postReview(postId),
        body: {
          'content': content,
          'medias': medias.map((media) => media.toJson()).toList(),
          'rating': rating
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      );
    } catch (e) {
      log(e.toString(), name: 'REMOTE_REVIEW_DATASOURCE');
      rethrow;
    }
  }
}
