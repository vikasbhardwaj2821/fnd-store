import 'package:get/get.dart';

class DashboardController extends GetxController {
  final currentIndex = 0.obs;

  void changeTab(int index) {
    if (index != 2) currentIndex.value = index;
  }
}
