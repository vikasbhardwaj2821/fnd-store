import '../models/cms_model.dart';
import '../models/user_model.dart';
import '../shared/api_helper.dart';
import '../shared/api_response.dart';
import 'api_constant.dart';
import 'base_client.dart';

class SettingsApiProvider {
  const SettingsApiProvider(this._apiHelper);

  final ApiHelper _apiHelper;

  Future<ApiResponse<Map<String, dynamic>>> logout() {
    return _apiHelper.callApi<Map<String, dynamic>>(
      ApiConstants.logout,
      RequestType.post,
      showLoading: true,
      fromJsonT: (data) =>
          data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{},
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> deleteAccount() {
    return _apiHelper.callApi<Map<String, dynamic>>(
      ApiConstants.deleteAccount,
      RequestType.delete,
      body: const {
        'reason': 'I no longer need this account',
      },
      showLoading: true,
      fromJsonT: (data) =>
          data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{},
    );
  }

  Future<ApiResponse<CmsModel>> getCms(String type) {
    return _apiHelper.callApi<CmsModel>(
      ApiConstants.cms(type),
      RequestType.get,
      showLoading: true,
      fromJsonT: (data) {
        final responseData = data is Map
            ? Map<String, dynamic>.from(data)
            : <String, dynamic>{};
        final content = responseData['content'];
        return CmsModel.fromJson(
          content is Map
              ? Map<String, dynamic>.from(content)
              : <String, dynamic>{},
        );
      },
    );
  }

  Future<ApiResponse<UserModel>> getProfile() {
    return _apiHelper.callApi<UserModel>(
      ApiConstants.profile,
      RequestType.get,
      showLoading: false,
      fromJsonT: (data) =>
          UserModel.fromJson(Map<String, dynamic>.from(data as Map)),
    );
  }

  Future<ApiResponse<UserModel>> updateSettings(Map<String, dynamic> body) {
    return _apiHelper.callApi<UserModel>(
      ApiConstants.settings,
      RequestType.put,
      body: body,
      showLoading: true,
      fromJsonT: (data) =>
          UserModel.fromJson(Map<String, dynamic>.from(data as Map)),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> createRequest(
    Map<String, dynamic> body,
  ) {
    return _apiHelper.callApi<Map<String, dynamic>>(
      ApiConstants.createRequest,
      RequestType.post,
      body: body,
      showLoading: true,
      fromJsonT: (data) =>
          data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{},
    );
  }
}
