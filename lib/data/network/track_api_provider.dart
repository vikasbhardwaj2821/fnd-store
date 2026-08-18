import '../models/request_track_model.dart';
import '../shared/api_helper.dart';
import '../shared/api_response.dart';
import 'api_constant.dart';
import 'base_client.dart';

class TrackApiProvider {
  const TrackApiProvider(this._apiHelper);

  final ApiHelper _apiHelper;

  Future<ApiResponse<RequestTrackModel>> getTrackDetails(String id) {
    return _apiHelper.callApi<RequestTrackModel>(
      '${ApiConstants.trackRequest}/$id',
      RequestType.get,
      showLoading: true,
      fromJsonT: (data) => RequestTrackModel.fromJson(
        data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{},
      ),
    );
  }
}
