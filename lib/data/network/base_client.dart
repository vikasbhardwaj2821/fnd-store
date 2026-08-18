import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum RequestType { get, post, put, patch, delete }

class ApiRequest {
  const ApiRequest({
    required this.url,
    required this.requestType,
    this.body,
    this.formData,
    this.isMultipart = false,
  });
  final String url;
  final RequestType requestType;
  final Map<String, dynamic>? body;
  final FormData? formData;
  final bool isMultipart;
}

typedef AccessTokenProvider = Future<String?> Function();

class BaseClient {
  BaseClient({Dio? dio, this._accessTokenProvider}) : _dio = dio ?? Dio() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: const {'Accept': 'application/json'},
      validateStatus: (status) => status != null && status < 600,
    );
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  final Dio _dio;
  final AccessTokenProvider? _accessTokenProvider;

  Future<Response<dynamic>> handleRequest(ApiRequest request) async {
    final token = await _accessTokenProvider?.call();
    if (kDebugMode) {
      debugPrint(
        'AUTH TOKEN: ${token == null || token.isEmpty ? '(none)' : 'Bearer $token'}',
      );
    }
    final options = Options(
      headers: token == null || token.isEmpty
          ? null
          : {'Authorization': 'Bearer $token'},
      contentType: request.isMultipart
          ? Headers.multipartFormDataContentType
          : Headers.jsonContentType,
    );
    final body = request.isMultipart
        ? (request.formData ?? FormData.fromMap(request.body ?? const {}))
        : request.body;

    switch (request.requestType) {
      case RequestType.get:
        return _dio.get(
          request.url,
          queryParameters: request.body,
          options: options,
        );
      case RequestType.post:
        return _dio.post(request.url, data: body, options: options);
      case RequestType.put:
        return _dio.put(request.url, data: body, options: options);
      case RequestType.patch:
        return _dio.patch(request.url, data: body, options: options);
      case RequestType.delete:
        return _dio.delete(request.url, data: body, options: options);
    }
  }

  static Future<MultipartFile> filePart(File file) =>
      MultipartFile.fromFile(file.path);
}
