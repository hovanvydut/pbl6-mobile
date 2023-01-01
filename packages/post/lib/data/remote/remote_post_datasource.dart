import 'dart:developer';
import 'dart:io';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:post/post.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';

class RemotePostDatasource implements IPostDatasource {
  RemotePostDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<void> createPost({
    required String title,
    required String description,
    required double area,
    required String address,
    required int wardId,
    required double price,
    required double prePaidPrice,
    required int houseTypeId,
    required int limitTenant,
    List<Media>? medias,
    required List<int> properties,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.post(
        ApiPath.post,
        body: {
          'title': title,
          'description': description,
          'area': area,
          'address': address,
          'addressWardId': wardId,
          'price': price,
          'prePaidPrice': prePaidPrice,
          'categoryId': houseTypeId,
          'limitTenant': limitTenant,
          'medias': medias
              ?.map<Map<String, dynamic>>((media) => media.toJson())
              .toList(),
          'properties': properties
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      );
    } catch (e) {
      log(e.toString(), name: 'REMOTE_POST_DATASOURCE');
      rethrow;
    }
  }

  @override
  Future<List<Post>> getAllPosts({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final responseData = await _httpHandler.get(
        ApiPath.post,
        queryParameter: {
          'PageNumber': '$pageNumber',
          'PageSize': '$pageSize',
        },
      );
      final data = responseData.data as Map<String, dynamic>;
      final postsData = data['records'] as List;
      return postsData
          .map((data) => Post.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString(), name: 'REMOTE_POST_DATASOURCE');
      rethrow;
    }
  }

  @override
  Future<List<Post>> getUserPosts({
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      final responseData = await _httpHandler.get(
        ApiPath.hostPostPersonal,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
        queryParameter: Map.fromEntries(
          {
            'PageNumber': '$pageNumber',
            'PageSize': '$pageSize',
            'SearchValue': searchValue,
          }.entries.toList()
            ..removeWhere((entry) => entry.value == null),
        ),
      );
      final data = responseData.data as Map<String, dynamic>;
      final postsData = data['records'] as List;
      return postsData
          .map((data) => Post.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString(), name: 'REMOTE_POST_DATASOURCE');
      rethrow;
    }
  }

  @override
  Future<void> updatePostByPostId(
    int postId, {
    required String title,
    required String description,
    required double area,
    required String address,
    required int wardId,
    required double price,
    required double prePaidPrice,
    required int houseTypeId,
    required int limitTenant,
    List<Media>? medias,
    required List<int> properties,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.put(
        '${ApiPath.post}/$postId',
        body: {
          'title': title,
          'description': description,
          'area': area,
          'address': address,
          'addressWardId': wardId,
          'price': price,
          'prePaidPrice': prePaidPrice,
          'categoryId': houseTypeId,
          'limitTenant': limitTenant,
          'medias': medias!
              .map<Map<String, dynamic>>((media) => media.toJson())
              .toList(),
          'properties': properties,
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePost(int postId) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.delete(
        '${ApiPath.post}/$postId',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
    } catch (e) {
      log(e.toString(), name: 'REMOTE_POST_DATASOURCE');
      rethrow;
    }
  }

  @override
  Future<List<Post>> filterPosts({
    List<int>? properties,
    double? minPrice,
    double? maxPrice,
    double? minArea,
    double? maxArea,
    int? addressDistrictId,
    int? categoryId,
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      final responseData = await _httpHandler.get(
        ApiPath.post,
        queryParameter: Map.fromEntries(
          {
            'Properties': properties?.join(','),
            'MinPrice': maxPrice == null ? null : '$minPrice',
            'MaxPrice': maxPrice == null ? null : '$maxPrice',
            'MinArea': minArea == null ? null : '$minArea',
            'MaxArea': maxArea == null ? null : '$maxArea',
            'AddressDistrictId':
                addressDistrictId == null ? null : '$addressDistrictId',
            'CategoryId': categoryId == null ? null : '$categoryId',
            'PageNumber': '$pageNumber',
            'PageSize': '$pageSize',
            'SearchValue': searchValue,
          }.entries.toList()
            ..removeWhere((entry) => entry.value == null),
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
      final data = responseData.data as Map<String, dynamic>;
      final postsData = data['records'] as List;
      return postsData
          .map((data) => Post.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString(), name: 'REMOTE_POST_DATASOURCE');
      rethrow;
    }
  }

  @override
  Future<Post> getDetailPostById(int postId) async {
    try {
      final responseData = await _httpHandler.get('${ApiPath.post}/$postId');
      return Post.fromJson(responseData.data as Map<String, dynamic>);
    } catch (e) {
      log(e.toString(), name: 'REMOTE_POST_DATASOURCE');
      rethrow;
    }
  }

  @override
  Future<List<Post>> getPostsByHostId(int hostId) async {
    try {
      final responseData =
          await _httpHandler.get(ApiPath.hostPostOther(hostId));
      final data = responseData.data as Map<String, dynamic>;
      final postsData = data['records'] as List;
      return postsData
          .map((data) => Post.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString(), name: 'REMOTE_POST_DATASOURCE');
      rethrow;
    }
  }
}
