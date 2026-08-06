import 'package:get/get.dart';

class DashboardController extends GetxController {
  final currentIndex = 0.obs;
  final hasCreatedRequest = false.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    hasCreatedRequest.value =
        arguments is Map && arguments['hasCreatedRequest'] == true;
  }

  void changeTab(int index) {
    if (index != 2) currentIndex.value = index;
  }
}
