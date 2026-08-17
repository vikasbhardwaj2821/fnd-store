import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../data/network/auth_api_provider.dart';
import '../../../data/network/google_places_service.dart';
import '../../../data/validators/validator.dart';
import '../../../utils/common/camera_helper.dart';
import '../../../utils/utils.dart';

class StoreDetailsController extends GetxController
    implements CameraOnCompleteListener {
  StoreDetailsController(this._apiProvider, this._placesService) {
    cameraHelper = CameraHelper(this);
  }

  final AuthApiProvider _apiProvider;
  final GooglePlacesService _placesService;
  final storeNameController = TextEditingController();
  final storeLocationController = TextEditingController();
  final Rxn<File> storeImage = Rxn<File>();
  final suggestions = <PlaceSuggestion>[].obs;
  final RxnDouble latitude = RxnDouble();
  final RxnDouble longitude = RxnDouble();
  Timer? _searchTimer;
  bool _selectingPlace = false;
  late final CameraHelper cameraHelper;

  void openPhotoPicker(BuildContext context) {
    cameraHelper.openImagePicker();
  }

  @override
  void onSuccessFile(String file, String fileType) {
    if (fileType == 'image') {
      storeImage.value = File(file);
      debugPrint('📸 Image selected path: $file');
    }
  }

  void searchLocation(String query) {
    if (_selectingPlace) return;
    latitude.value = null;
    longitude.value = null;
    _searchTimer?.cancel();
    if (query.trim().length < 3) {
      suggestions.clear();
      return;
    }
    _searchTimer = Timer(const Duration(milliseconds: 400), () async {
      try {
        suggestions.assignAll(await _placesService.autocomplete(query));
      } catch (_) {
        suggestions.clear();
      }
    });
  }

  Future<void> selectPlace(PlaceSuggestion suggestion) async {
    suggestions.clear();
    try {
      final place = await _placesService.getPlace(suggestion.id);
      if (place == null) {
        Utils.showSnackBar('Unable to find this location.');
        return;
      }
      _selectingPlace = true;
      storeLocationController.text = place.address.isEmpty
          ? suggestion.description
          : place.address;
      _selectingPlace = false;
      latitude.value = place.latitude;
      longitude.value = place.longitude;
    } catch (_) {
      _selectingPlace = false;
      Utils.showSnackBar('Unable to find this location.');
    }
  }

  Future<bool> submitStoreDetails() async {
    Utils.hideKeyboard(Get.context!);
    if (!Validator.validateStore(
      name: storeNameController,
      location: storeLocationController,
    )) {
      return false;
    }
    if (latitude.value == null || longitude.value == null) {
      Utils.showSnackBar(
        'Please select a location from the Google suggestions.',
      );
      return false;
    }
    final body = <String, dynamic>{
      'storeName': storeNameController.text.trim(),
      'location': storeLocationController.text.trim(),
      'latitude': latitude.value.toString(),
      'longitude': longitude.value.toString(),
    };
    final imagePath = storeImage.value?.path ?? '';
    if (imagePath.isNotEmpty) {
      body['storeImage'] = imagePath.split('/').last;
    }

    final response = await _apiProvider.addStoreDetails(body);
    if (response.success) return true;
    Utils.showSnackBar(
      response.message ?? 'Unable to save store details. Please try again.',
    );
    return false;
  }

  void continueToHome() {
    Utils.hideKeyboard(Get.context!);
    Get.offAllNamed<void>(AppRoutes.dashboard);
  }

  void saveAndGoBack() {
    Utils.hideKeyboard(Get.context!);
    Get.back<void>();
  }

  @override
  void onClose() {
    _searchTimer?.cancel();
    storeNameController.dispose();
    storeLocationController.dispose();
    super.onClose();
  }
}
