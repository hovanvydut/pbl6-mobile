import 'dart:developer';
import 'dart:io';

import 'package:bookmark/bookmark.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/src/post/post.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';

class RemoteBookmarkDatasource implements IBookmarkDatasource {
  RemoteBookmarkDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<void> addBookmark(int postId) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.post(
        ApiPath.bookmark,
        body: {
          'postId': postId,
        },
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Post>> getBookmarks({
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      final responseData = await _httpHandler.get(
        ApiPath.bookmark,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
        queryParameter: {
          'PageNumber': '$pageNumber',
          'PageSize': '$pageSize',
          'SearchValue': searchValue,
        },
      );
      final data = responseData.data as Map<String, dynamic>;
      final postsData = data['records'] as List;
      return postsData
          .map((data) => Post.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteBookmark(int postId) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.delete(
        ApiPath.bookmark + '/$postId',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
