import '../shared/api_helper.dart';
import '../shared/api_response.dart';
import 'api_constant.dart';
import 'base_client.dart';

class SupportApiProvider {
  const SupportApiProvider(this._apiHelper);

  final ApiHelper _apiHelper;

  Future<ApiResponse<Map<String, dynamic>>> sendSupportMessage(
    Map<String, dynamic> body,
  ) {
    return _apiHelper.callApi<Map<String, dynamic>>(
      ApiConstants.support,
      RequestType.post,
      body: body,
      showLoading: true,
      fromJsonT: (data) =>
          data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{},
    );
  }
}
