import '../models/booking_model.dart';
import '../shared/api_helper.dart';
import '../shared/api_response.dart';
import 'api_constant.dart';
import 'base_client.dart';

class BookingsApiProvider {
  const BookingsApiProvider(this._apiHelper);

  final ApiHelper _apiHelper;

  Future<ApiResponse<List<BookingModel>>> getBookings(String tab) {
    return _apiHelper.callApi<List<BookingModel>>(
      '${ApiConstants.storeBookings}?tab=$tab',
      RequestType.get,
      showLoading: false,
      fromJsonT: (data) {
        final responseData = data is Map
            ? Map<String, dynamic>.from(data)
            : <String, dynamic>{};
        return BookingModel.fromJsonList(responseData['bookings']);
      },
    );
  }
}
