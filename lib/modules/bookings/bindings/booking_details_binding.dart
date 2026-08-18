import 'package:get/get.dart';

import '../../../data/network/base_client.dart';
import '../../../data/network/track_api_provider.dart';
import '../../../data/shared/api_helper.dart';
import '../../../data/shared/auth_session.dart';
import '../controllers/booking_details_controller.dart';

class BookingDetailsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<BaseClient>()) {
      Get.put<BaseClient>(
        BaseClient(accessTokenProvider: () async => AuthSession.instance.token),
      );
    }
    if (!Get.isRegistered<ApiHelper>()) {
      Get.put<ApiHelper>(ApiHelper(Get.find<BaseClient>()));
    }
    if (!Get.isRegistered<TrackApiProvider>()) {
      Get.put<TrackApiProvider>(TrackApiProvider(Get.find<ApiHelper>()));
    }
    Get.lazyPut<BookingDetailsController>(
      () => BookingDetailsController(Get.find<TrackApiProvider>()),
    );
  }
}
