import 'package:get/get.dart';

import '../../../data/models/booking_model.dart';
import '../../../data/network/bookings_api_provider.dart';
import '../../../utils/utils.dart';

class BookingsController extends GetxController {
  BookingsController(this._apiProvider);

  final BookingsApiProvider _apiProvider;
  final selectedTab = 0.obs;
  final isLoading = false.obs;
  final bookingsByTab = <String, List<BookingModel>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllTabs();
  }

  void setTab(int index) {
    selectedTab.value = index;
    fetchTab(_tabName(index));
  }

  String _tabName(int index) {
    switch (index) {
      case 1:
        return 'upcoming';
      case 2:
        return 'completed';
      default:
        return 'ongoing';
    }
  }

  List<BookingModel> bookingsForSelectedTab() =>
      bookingsByTab[_tabName(selectedTab.value)] ?? const [];

  Future<void> fetchTab(String tab) async {
    isLoading.value = true;
    final response = await _apiProvider.getBookings(tab);
    isLoading.value = false;
    if (!response.success || response.body == null) {
      Utils.showSnackBar(
        response.message ?? 'Unable to load bookings. Please try again.',
      );
      return;
    }
    bookingsByTab[tab] = response.body ?? <BookingModel>[];
    bookingsByTab.refresh();
  }

  Future<void> fetchAllTabs() async {
    isLoading.value = true;
    final results = await Future.wait([
      _apiProvider.getBookings('ongoing'),
      _apiProvider.getBookings('upcoming'),
      _apiProvider.getBookings('completed'),
    ]);
    isLoading.value = false;

    for (final entry in [
      ('ongoing', results[0]),
      ('upcoming', results[1]),
      ('completed', results[2]),
    ]) {
      final tab = entry.$1;
      final response = entry.$2;
      if (response.success && response.body != null) {
        bookingsByTab[tab] = response.body ?? <BookingModel>[];
      }
    }
    bookingsByTab.refresh();
  }
}
