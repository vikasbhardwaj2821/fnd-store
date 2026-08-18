import '../shared/api_helper.dart';
import '../shared/api_response.dart';
import 'api_constant.dart';
import 'base_client.dart';

class HomeApiProvider {
  const HomeApiProvider(this.apiHelper);

  final ApiHelper apiHelper;

  Future<ApiResponse<Map<String, dynamic>>> getHome() {
    return apiHelper.callApi<Map<String, dynamic>>(
      ApiConstants.home,
      RequestType.get,
      showLoading: false,
      fromJsonT: (data) =>
          data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{},
    );
  }
}
