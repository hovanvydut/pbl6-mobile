// Copyright (c) 2022, Nguyen Minh Dung
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_client_handler/http_client_handler.dart';

/// {@template http_client_handler}
/// A http client handler for base api client
/// {@endtemplate}
class HttpClientHandler {
  /// {@macro http_client_handler}
  HttpClientHandler({
    http.Client? client,
    String? baseUrl,
  })  : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? 'http://10.0.2.2:8080';

  final http.Client _client;

  final String _baseUrl;

  Future<CommonResponse> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      final uri = _getUri(
        baseUrl: _baseUrl,
        path: path,
        queryParameter: queryParameter,
      );
      log(uri.toString(), name: 'HTTP_CLIENT_HANDLER_GET');
      return _client.get(uri, headers: headers).then(_handleResponse);
    } on SocketException {
      rethrow;
    }
  }

  Future<CommonResponse> post(
    String path, {
    Object? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      final uri = _getUri(
        baseUrl: _baseUrl,
        path: path,
        queryParameter: queryParameter,
      );
      log(uri.toString(), name: 'HTTP_CLIENT_HANDLER_POST');
      return _client
          .post(uri, headers: headers, body: jsonEncode(body))
          .then(_handleResponse);
    } on SocketException {
      rethrow;
    }
  }

  Future<CommonResponse> put(
    String path, {
    Object? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      final uri = _getUri(
        baseUrl: _baseUrl,
        path: path,
        queryParameter: queryParameter,
      );
      log(uri.toString(), name: 'HTTP_CLIENT_HANDLER_PUT');

      return _client
          .put(uri, headers: headers, body: jsonEncode(body))
          .then(_handleResponse);
    } on SocketException {
      rethrow;
    }
  }

  Future<CommonResponse> delete(
    String path, {
    Object? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      final uri = _getUri(
        baseUrl: _baseUrl,
        path: path,
        queryParameter: queryParameter,
      );
      log(uri.toString(), name: 'HTTP_CLIENT_HANDLER_DELETE');

      return _client
          .delete(uri, headers: headers, body: jsonEncode(body))
          .then(_handleResponse);
    } on SocketException {
      rethrow;
    }
  }

  Future<CommonResponse> postFile(
    String path, {
    required http.MultipartFile multipartFile,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    final uri = _getUri(
      baseUrl: _baseUrl,
      path: path,
      queryParameter: queryParameter,
    );
    log(uri.toString(), name: 'HTTP_CLIENT_HANDLER_MULTIPART_POST');

    final request = http.MultipartRequest('POST', uri)
      ..files.add(
        multipartFile,
      )
      ..headers;
    final response = await request.send();
    return _handleResponse(await _fromStream(response));
  }

  CommonResponse _handleResponse(http.Response response) {
    log(response.body, name: 'HTTP_CLIENT_HANDLER');
    final body =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    final commonResponse = CommonResponse.fromJson(body);
    if (HttpStatus.ok <= commonResponse.statusCode &&
        commonResponse.statusCode <= HttpStatus.multipleChoices) {
      return commonResponse;
    } else {
      switch (commonResponse.statusCode) {
        case 400:
          throw BadRequestException(message: commonResponse.message);
        case 401:
          throw UnauthorizedException(message: commonResponse.message);
        case 404:
          throw NotFoundException(message: commonResponse.message);
        case 500:
          throw ServerErrorException();
        default:
          throw Exception(
            'Error occured while Communication'
            ' with Server with StatusCode : ${response.statusCode}',
          );
      }
    }
  }

  Future<Uint8List> _toBytes(
    http.ByteStream stream,
  ) {
    final completer = Completer<Uint8List>();
    final sink = ByteConversionSink.withCallback(
      (bytes) => completer.complete(Uint8List.fromList(bytes)),
    );

    stream.listen(
      sink.add,
      onError: completer.completeError,
      onDone: sink.close,
      cancelOnError: true,
    );

    return completer.future;
  }

  Future<http.Response> _fromStream(
    http.StreamedResponse response,
  ) async {
    final body = await _toBytes(response.stream);

    return http.Response.bytes(
      body,
      response.statusCode,
      request: response.request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
    );
  }

  Uri _getUri({
    required String baseUrl,
    required String path,
    Map<String, dynamic>? queryParameter,
  }) {
    final splited = baseUrl.split('://');
    final schema = splited.first;
    final hostPort = splited[1].split(':');
    final host = hostPort.first;
    final port = hostPort.length == 1 ? null : int.parse(hostPort[1]);
    return Uri(
      scheme: schema,
      host: host,
      path: path,
      port: port,
      queryParameters: queryParameter,
    );
  }
}
