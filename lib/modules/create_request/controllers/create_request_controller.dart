import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/network/google_places_service.dart';
import '../../../data/network/settings_api_provider.dart';
import '../../../data/validators/validator.dart';
import '../../../utils/common/camera_helper.dart';
import '../../../utils/common/countries.dart';
import '../../../utils/utils.dart';

class CreateRequestController extends GetxController
    implements CameraOnCompleteListener {
  CreateRequestController(this._apiProvider, this._placesService) {
    cameraHelper = CameraHelper(this);
  }

  final SettingsApiProvider _apiProvider;
  final GooglePlacesService _placesService;
  final customerNameController = TextEditingController();
  final phoneController = TextEditingController();
  final pickupController = TextEditingController();
  final dropoffController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final instructionsController = TextEditingController();
  TimeOfDay? _selectedTime;
  final Rxn<File> productImage = Rxn<File>();
  final pickupSuggestions = <PlaceSuggestion>[].obs;
  final dropoffSuggestions = <PlaceSuggestion>[].obs;
  final RxnDouble pickupLatitude = RxnDouble();
  final RxnDouble pickupLongitude = RxnDouble();
  final RxnDouble dropoffLatitude = RxnDouble();
  final RxnDouble dropoffLongitude = RxnDouble();
  final Rx<Country> selectedCountry = allCountries
      .firstWhere((country) => country.code == 'AE')
      .obs;
  Timer? _pickupTimer;
  Timer? _dropoffTimer;
  bool _selectingPickupPlace = false;
  bool _selectingDropoffPlace = false;
  late final CameraHelper cameraHelper;

  Future<void> pickProductImage() async {
    cameraHelper.openImagePicker();
  }

  void selectCountry(Country country) {
    selectedCountry.value = country;
    phoneController.clear();
  }

  @override
  void onSuccessFile(String file, String fileType) {
    if (fileType == 'image') {
      productImage.value = File(file);
      debugPrint('📸 Image selected path: $file');
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final value = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (value != null) {
      dateController.text = _formatDate(value);
      if (_isSelectedTimeInPast()) {
        timeController.clear();
        _selectedTime = null;
        Utils.showSnackBar('Please select a valid time for today.');
      }
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final value = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (value != null && context.mounted) {
      if (_isSelectedTimeInPast(value)) {
        timeController.clear();
        _selectedTime = null;
        Utils.showSnackBar('Please select a valid time for today.');
        return;
      }
      _selectedTime = value;
      timeController.text = _formatTime24(context, value);
    }
  }

  void searchPickupLocation(String query) {
    if (_selectingPickupPlace) return;
    pickupLatitude.value = null;
    pickupLongitude.value = null;
    _pickupTimer?.cancel();
    if (query.trim().length < 3) {
      pickupSuggestions.clear();
      return;
    }
    _pickupTimer = Timer(const Duration(milliseconds: 400), () async {
      try {
        pickupSuggestions.assignAll(await _placesService.autocomplete(query));
      } catch (_) {
        pickupSuggestions.clear();
      }
    });
  }

  void searchDropoffLocation(String query) {
    if (_selectingDropoffPlace) return;
    dropoffLatitude.value = null;
    dropoffLongitude.value = null;
    _dropoffTimer?.cancel();
    if (query.trim().length < 3) {
      dropoffSuggestions.clear();
      return;
    }
    _dropoffTimer = Timer(const Duration(milliseconds: 400), () async {
      try {
        dropoffSuggestions.assignAll(await _placesService.autocomplete(query));
      } catch (_) {
        dropoffSuggestions.clear();
      }
    });
  }

  Future<void> selectPickupPlace(PlaceSuggestion suggestion) async {
    pickupSuggestions.clear();
    try {
      final place = await _placesService.getPlace(suggestion.id);
      if (place == null) {
        Utils.showSnackBar('Unable to find this location.');
        return;
      }
      _selectingPickupPlace = true;
      pickupController.text = place.address.isEmpty
          ? suggestion.description
          : place.address;
      _selectingPickupPlace = false;
      pickupLatitude.value = place.latitude;
      pickupLongitude.value = place.longitude;
    } catch (_) {
      _selectingPickupPlace = false;
      Utils.showSnackBar('Unable to find this location.');
    }
  }

  Future<void> selectDropoffPlace(PlaceSuggestion suggestion) async {
    dropoffSuggestions.clear();
    try {
      final place = await _placesService.getPlace(suggestion.id);
      if (place == null) {
        Utils.showSnackBar('Unable to find this location.');
        return;
      }
      _selectingDropoffPlace = true;
      dropoffController.text = place.address.isEmpty
          ? suggestion.description
          : place.address;
      _selectingDropoffPlace = false;
      dropoffLatitude.value = place.latitude;
      dropoffLongitude.value = place.longitude;
    } catch (_) {
      _selectingDropoffPlace = false;
      Utils.showSnackBar('Unable to find this location.');
    }
  }

  Future<void> createRequest() async {
    Utils.hideKeyboard(Get.context!);
    if (!Validator.validateCreateRequest(
      customerName: customerNameController,
      phone: phoneController,
      country: selectedCountry.value,
      hasImage: productImage.value != null,
      pickupLocation: pickupController,
      dropoffLocation: dropoffController,
      date: dateController,
      time: timeController,
      instructions: instructionsController,
    )) {
      return;
    }
    if (pickupLatitude.value == null || pickupLongitude.value == null) {
      Utils.showSnackBar('Please select a pickup location from suggestions.');
      return;
    }
    if (dropoffLatitude.value == null || dropoffLongitude.value == null) {
      Utils.showSnackBar('Please select a drop-off location from suggestions.');
      return;
    }
    final body = <String, dynamic>{
      'recipientName': customerNameController.text.trim(),
      'recipientPhone':
          '+${selectedCountry.value.dialCode}${phoneController.text.trim()}',
      'pickupLocation': pickupController.text.trim(),
      'pickupLatitude': pickupLatitude.value.toString(),
      'pickupLongitude': pickupLongitude.value.toString(),
      'dropoffLocation': dropoffController.text.trim(),
      'dropoffLatitude': dropoffLatitude.value.toString(),
      'dropoffLongitude': dropoffLongitude.value.toString(),
      'scheduledDate': _apiDateFromDisplay(dateController.text.trim()),
      'scheduledTimeFrom': timeController.text.trim(),
      'scheduledTimeTo': timeController.text.trim(),
      'distance': 0,
      'price': 0,
      'packageInstructions': instructionsController.text.trim(),
    };

    final imagePath = productImage.value?.path ?? '';
    if (imagePath.isNotEmpty) {
      body['packageImage'] = imagePath.split('/').last;
    } else {
      body['packageImage'] = '';
    }

    final response = await _apiProvider.createRequest(body);
    if (response.success) {
      Utils.showSnackBar(response.message ?? 'Request created successfully.');
      Get.back(result: true);
      return;
    }
    Utils.showSnackBar(
      response.message ?? 'Unable to create request. Please try again.',
    );
  }

  bool _isSelectedTimeInPast([TimeOfDay? candidate]) {
    final rawDate = dateController.text.trim();
    final selectedDate = _parseDate(rawDate);
    if (selectedDate == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDay = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    if (selectedDay != today) return false;

    final selectedTime = candidate ?? _selectedTime;
    if (selectedTime == null) return false;
    final nowMinutes = now.hour * 60 + now.minute;
    final selectedMinutes = selectedTime.hour * 60 + selectedTime.minute;
    return selectedMinutes < nowMinutes;
  }

  DateTime? _parseDate(String value) {
    final parts = value.split('/');
    if (parts.length != 3) return null;
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) return null;
    return DateTime(year, month, day);
  }

  String _formatDate(DateTime value) {
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/${value.year}';
  }

  String _apiDateFromDisplay(String value) {
    final parsed = _parseDate(value);
    if (parsed == null) return value;
    return '${parsed.year.toString().padLeft(4, '0')}-'
        '${parsed.month.toString().padLeft(2, '0')}-'
        '${parsed.day.toString().padLeft(2, '0')}';
  }

  String _formatTime24(BuildContext context, TimeOfDay time) {
    return MaterialLocalizations.of(context).formatTimeOfDay(
      time,
      alwaysUse24HourFormat: true,
    );
  }

  @override
  void onClose() {
    _pickupTimer?.cancel();
    _dropoffTimer?.cancel();
    customerNameController.dispose();
    phoneController.dispose();
    pickupController.dispose();
    dropoffController.dispose();
    dateController.dispose();
    timeController.dispose();
    instructionsController.dispose();
    super.onClose();
  }
}
