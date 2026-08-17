import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../utils/utils.dart';
import '../network/base_client.dart';
import 'api_response.dart';

typedef UnauthorizedCallback = Future<void> Function();

class ApiHelper {
  const ApiHelper(this._client, {this.onUnauthorized});
  final BaseClient _client;
  final UnauthorizedCallback? onUnauthorized;

  Future<ApiResponse<T>> callApi<T>(
    String url,
    RequestType method, {
    Map<String, dynamic>? body,
    required T Function(dynamic) fromJsonT,
    bool showLoading = true,
    bool isMultipart = false,
    FormData? formData,
  }) async {
    if (kDebugMode) {
      debugPrint('API ${method.name.toUpperCase()} $url');
      debugPrint('REQUEST BODY: ${_formatBody(body, formData: formData)}');
    }

    if (showLoading) Utils.showLoading();
    try {
      final response = await _client.handleRequest(
        ApiRequest(
          url: url,
          requestType: method,
          body: body,
          formData: formData,
          isMultipart: isMultipart,
        ),
      );
      final data = response.data;
      final json = data is Map
          ? Map<String, dynamic>.from(data)
          : <String, dynamic>{};
      if (response.statusCode == 401 ||
          json['code'] == 401 ||
          json['status'] == 401) {
        await onUnauthorized?.call();
        return ApiResponse<T>(
          success: false,
          code: 401,
          message: json['message']?.toString() ?? 'Session expired',
        );
      }
      if (data is! Map) {
        return ApiResponse<T>(
          success: false,
          code: response.statusCode,
          message: 'Unexpected server response',
        );
      }
      final parsed = ApiResponse<T>.fromJson(json, fromJsonT);
      if ((response.statusCode ?? 500) >= 400 && parsed.success) {
        return ApiResponse<T>(
          success: false,
          code: response.statusCode,
          message: parsed.message,
        );
      }
      return parsed;
    } on DioException catch (error, stackTrace) {
      debugPrint('API error: $error\n$stackTrace');
      return ApiResponse<T>(
        success: false,
        code: error.response?.statusCode,
        message: _messageFor(error),
      );
    } catch (error, stackTrace) {
      debugPrint('API parsing error: $error\n$stackTrace');
      return ApiResponse<T>(
        success: false,
        message: 'Unable to process the server response',
      );
    } finally {
      if (showLoading) Utils.hideLoading();
    }
  }

  String _messageFor(DioException error) {
    final response = error.response?.data;
    if (response is Map && response['message'] != null) {
      return response['message'].toString();
    }
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout =>
        'The request timed out. Please try again.',
      DioExceptionType.connectionError => 'No internet connection.',
      _ => 'Something went wrong. Please try again.',
    };
  }

  String _formatBody(Map<String, dynamic>? body, {FormData? formData}) {
    if (formData != null) {
      final normalized = <String, dynamic>{};

      for (final entry in formData.fields) {
        normalized[entry.key] = entry.value;
      }

      for (final fileEntry in formData.files) {
        final value = fileEntry.value;
        normalized[fileEntry.key] = {
          'type': 'MultipartFile',
          'filename': value.filename,
          'length': value.length,
        };
      }

      return normalized.isEmpty ? '{}' : normalized.toString();
    }

    if (body == null || body.isEmpty) return '{}';

    final normalized = <String, dynamic>{};
    body.forEach((key, value) {
      if (value is MultipartFile) {
        normalized[key] = {
          'type': 'MultipartFile',
          'filename': value.filename,
          'length': value.length,
        };
        return;
      }

      normalized[key] = value;
    });

    return normalized.toString();
  }
}
