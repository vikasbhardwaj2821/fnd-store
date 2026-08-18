import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

import '../../../data/models/request_track_model.dart';
import '../../../data/network/track_api_provider.dart';
import '../../../utils/utils.dart';

class BookingDetailsController extends GetxController {
  BookingDetailsController(this._apiProvider);

  final TrackApiProvider _apiProvider;
  final Rxn<RequestTrackModel> trackData = Rxn<RequestTrackModel>();
  final RxBool isLoading = false.obs;

  String? get requestId => Get.arguments is Map
      ? (Get.arguments as Map)['requestId']?.toString()
      : null;

  @override
  void onInit() {
    super.onInit();
    final id = requestId;
    if (id != null && id.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        fetchTrackDetails(id);
      });
    }
  }

  Future<void> fetchTrackDetails(String id) async {
    isLoading.value = true;
    final response = await _apiProvider.getTrackDetails(id);
    isLoading.value = false;
    if (!response.success || response.body == null) {
      Utils.showSnackBar(
        response.message ?? 'Unable to load booking details.',
      );
      return;
    }
    trackData.value = response.body;
  }
}
