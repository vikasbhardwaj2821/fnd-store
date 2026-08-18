import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/common/countries.dart';
import '../../utils/utils.dart';

abstract final class Validator {
  static bool validateLogin({
    required TextEditingController phoneController,
    required Country selectedCountry,
  }) {
    return validatePhone(phoneController, selectedCountry);
  }

  static bool validatePhone(TextEditingController controller, Country country) {
    final phone = controller.text.trim();
    final min = country.minLength ?? 6;
    final max = country.maxLength ?? 15;
    if (!RegExp(r'^(?!0+$)[0-9]+$').hasMatch(phone) ||
        phone.length < min ||
        phone.length > max) {
      return _error('Please enter a valid phone number.');
    }
    return true;
  }

  static bool validateOtp(Iterable<TextEditingController> controllers) {
    final otp = controllers.map((item) => item.text.trim()).join();
    return RegExp(r'^\d{4}$').hasMatch(otp) ||
        _error('Please enter the valid 4-digit verification code.');
  }

  static bool validateCompleteProfile({
    required TextEditingController firstName,
    required TextEditingController lastName,
    required TextEditingController email,
    required TextEditingController phone,
    required Country country,
    required bool acceptedTerms,
  }) {
    if (firstName.text.trim().isEmpty) {
      return _error('Please enter your first name.');
    }
    if (lastName.text.trim().isEmpty) {
      return _error('Please enter your last name.');
    }
    if (!email.text.trim().isEmail) {
      return _error('Please enter a valid email address.');
    }
    if (!validatePhone(phone, country)) return false;
    if (!acceptedTerms) {
      return _error('Please agree to the terms and conditions.');
    }
    return true;
  }

  static bool validateUpdateProfile({
    required TextEditingController firstName,
    required TextEditingController lastName,
    required TextEditingController email,
  }) {
    if (firstName.text.trim().isEmpty) {
      return _error('Please enter your first name.');
    }
    if (lastName.text.trim().isEmpty) {
      return _error('Please enter your last name.');
    }
    if (!email.text.trim().isEmail) {
      return _error('Please enter a valid email address.');
    }
    return true;
  }

  static bool validateStore({
    required TextEditingController name,
    required TextEditingController location,
  }) {
    if (name.text.trim().isEmpty) return _error('Please enter the store name.');
    if (location.text.trim().isEmpty) {
      return _error('Please enter the store location.');
    }
    return true;
  }

  static bool validateCreateRequest({
    required TextEditingController customerName,
    required TextEditingController phone,
    required Country country,
    required bool hasImage,
    required TextEditingController pickupLocation,
    required TextEditingController dropoffLocation,
    required TextEditingController date,
    required TextEditingController time,
    required TextEditingController instructions,
  }) {
    if (customerName.text.trim().isEmpty) {
      return _error('Please enter the recipient name.');
    }
    if (!validatePhone(phone, country)) return false;
    if (!hasImage) return _error('Please upload product image.');
    if (pickupLocation.text.trim().isEmpty) {
      return _error('Please enter the pickup location.');
    }
    if (dropoffLocation.text.trim().isEmpty) {
      return _error('Please enter the drop-off location.');
    }
    if (date.text.trim().isEmpty) return _error('Please select a date.');
    if (time.text.trim().isEmpty) return _error('Please select the time.');
    if (instructions.text.trim().isEmpty) {
      return _error('Please enter the instructions.');
    }
    return true;
  }

  static bool validateDeliveryRequest({
    required TextEditingController customerName,
    required TextEditingController phone,
    required Country country,
    required TextEditingController product,
    required TextEditingController pickup,
    required TextEditingController dropoff,
    required TextEditingController date,
    required TextEditingController time,
  }) {
    if (customerName.text.trim().isEmpty) {
      return _error('Please enter the customer name.');
    }
    if (!validatePhone(phone, country)) return false;
    if (product.text.trim().isEmpty) {
      return _error('Please enter the product name.');
    }
    if (pickup.text.trim().isEmpty) {
      return _error('Please enter the pickup address.');
    }
    if (dropoff.text.trim().isEmpty) {
      return _error('Please enter the drop-off address.');
    }
    if (date.text.trim().isEmpty) return _error('Please select a pickup date.');
    if (time.text.trim().isEmpty) return _error('Please select a pickup time.');
    return true;
  }

  static bool validateContact({
    required TextEditingController name,
    required TextEditingController email,
    required TextEditingController description,
  }) {
    if (name.text.trim().isEmpty) return _error('Please enter your name.');
    if (!email.text.trim().isEmail) {
      return _error('Please enter a valid email address.');
    }
    if (description.text.trim().isEmpty) {
      return _error('Please enter a description.');
    }
    return true;
  }

  static bool _error(String message) {
    Utils.showSnackBar(message);
    return false;
  }
}
