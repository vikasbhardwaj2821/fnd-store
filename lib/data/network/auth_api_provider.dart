import 'dart:io';

import '../models/user_model.dart';
import '../shared/api_helper.dart';
import '../shared/api_response.dart';
import 'api_constant.dart';
import 'base_client.dart';
import 'package:dio/dio.dart';

class AuthApiProvider {
  const AuthApiProvider(this._apiHelper);

  final ApiHelper _apiHelper;

  Future<ApiResponse<String>> uploadImage(File file) {
    return _apiHelper.callApi<String>(
      ApiConstants.upload,
      RequestType.post,
      showLoading: true,
      isMultipart: true,
      formData: FormData.fromMap({
        'image': MultipartFile.fromFileSync(
          file.path,
          filename: file.path.split('/').last,
        ),
      }),
      fromJsonT: (data) => data?.toString() ?? '',
    );
  }

  /// Logs in or registers a store user and sends an OTP.
  Future<ApiResponse<UserModel>> login(Map<String, dynamic> body) {
    return _apiHelper.callApi<UserModel>(
      ApiConstants.login,
      RequestType.post,
      body: body,
      showLoading: true,
      fromJsonT: (data) =>
          UserModel.fromJson(Map<String, dynamic>.from(data as Map)),
    );
  }

  /// Verifies the OTP and returns the authenticated user and token.
  Future<ApiResponse<UserModel>> verifyOtp(Map<String, dynamic> body) {
    return _apiHelper.callApi<UserModel>(
      ApiConstants.verifyOtp,
      RequestType.post,
      body: body,
      showLoading: true,
      fromJsonT: (data) =>
          UserModel.fromJson(Map<String, dynamic>.from(data as Map)),
    );
  }

  /// Creates a store account and sends its verification OTP.
  Future<ApiResponse<UserModel>> signup(Map<String, dynamic> body) {
    return _apiHelper.callApi<UserModel>(
      ApiConstants.signup,
      RequestType.post,
      body: body,
      showLoading: true,
      fromJsonT: (data) =>
          UserModel.fromJson(Map<String, dynamic>.from(data as Map)),
    );
  }

  /// Verifies the signup OTP and returns the registered user and token.
  Future<ApiResponse<UserModel>> verifySignupOtp(Map<String, dynamic> body) {
    return _apiHelper.callApi<UserModel>(
      ApiConstants.verifySignupOtp,
      RequestType.post,
      body: body,
      showLoading: true,
      fromJsonT: (data) =>
          UserModel.fromJson(Map<String, dynamic>.from(data as Map)),
    );
  }

  /// Updates the authenticated user's profile.
  Future<ApiResponse<UserModel>> completeProfile(Map<String, dynamic> body) {
    return _apiHelper.callApi<UserModel>(
      ApiConstants.completeProfile,
      RequestType.post,
      body: body,
      showLoading: true,
      fromJsonT: (data) =>
          UserModel.fromJson(Map<String, dynamic>.from(data as Map)),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> addStoreDetails(
    Map<String, dynamic> body,
  ) {
    return _apiHelper.callApi<Map<String, dynamic>>(
      ApiConstants.storeDetails,
      RequestType.post,
      body: body,
      showLoading: true,
      fromJsonT: (data) =>
          data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{},
    );
  }
}
