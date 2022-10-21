import 'dart:io';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:media/media.dart';

class RemoteMediaDatasource implements IMediaDatasource {
  const RemoteMediaDatasource({
    required HttpClientHandler httpHandler,
  }) : _httpHandler = httpHandler;
  final HttpClientHandler _httpHandler;

  @override
  Future<String> uploadImage(String fileName) async {
    try {
      final multiPartFile = await MultipartFile.fromPath('file', fileName);
      final response = await _httpHandler.postFile(
        ApiPath.mediaUpload,
        multipartFile: multiPartFile,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'multipart/form-data'
        },
      );
      return response.data as String;
    } catch (e) {
      rethrow;
    }
  }
}
