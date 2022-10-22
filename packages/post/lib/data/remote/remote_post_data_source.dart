import 'dart:developer';
import 'dart:io';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:post/post.dart';

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
      final response = await _httpHandler.post(
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
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
