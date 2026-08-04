import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final readItems = <int>{2, 3, 4}.obs;

  bool isRead(int index) => readItems.contains(index);
  void markAsRead(int index) => readItems.add(index);
  void markAllAsRead() => readItems.addAll(List.generate(5, (index) => index));
}
