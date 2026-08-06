import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/routes/app_routes.dart';
import '../../../utils/common/countries.dart';
import '../../../utils/utils.dart';

class CreateRequestController extends GetxController {
  final customerNameController = TextEditingController();
  final phoneController = TextEditingController();
  final productController = TextEditingController();
  final pickupController = TextEditingController();
  final dropoffController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final instructionsController = TextEditingController();
  final Rxn<File> productImage = Rxn<File>();
  final Rx<Country> selectedCountry = allCountries
      .firstWhere((country) => country.code == 'AE')
      .obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickProductImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1200,
    );
    if (image != null) productImage.value = File(image.path);
  }

  void selectCountry(Country country) {
    selectedCountry.value = country;
    phoneController.clear();
  }

  Future<void> selectDate(BuildContext context) async {
    final value = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (value != null) {
      dateController.text =
          '${value.day.toString().padLeft(2, '0')}/'
          '${value.month.toString().padLeft(2, '0')}/${value.year}';
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final value = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (value != null && context.mounted) {
      timeController.text = value.format(context);
    }
  }

  void createRequest() {
    Utils.hideKeyboard(Get.context!);
    Get.offAllNamed<void>(
      AppRoutes.dashboard,
      arguments: const {'hasCreatedRequest': true},
    );
  }

  @override
  void onClose() {
    customerNameController.dispose();
    phoneController.dispose();
    productController.dispose();
    pickupController.dispose();
    dropoffController.dispose();
    dateController.dispose();
    timeController.dispose();
    instructionsController.dispose();
    super.onClose();
  }
}
