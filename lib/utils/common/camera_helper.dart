import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'app_colors.dart';
import 'app_text.dart';

abstract class CameraOnCompleteListener {
  void onSuccessFile(String file, String fileType);
}

class CameraHelper {
  CameraHelper(this.callback);

  final ImagePicker _picker = ImagePicker();
  final BuildContext context = Get.context!;
  final CameraOnCompleteListener callback;

  void openImagePicker() {
    showAdaptiveActionSheet(
      context: context,
      isDismissible: true,
      bottomSheetColor: AppColors.white,
      actions: [
        BottomSheetAction(
          title: const Center(
            child: AppText(
              text: 'Choose from Library',
              textAlign: TextAlign.center,
              textSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          onPressed: (_) async {
            Get.back<void>();
            await _getImage(ImageSource.gallery);
          },
        ),
        BottomSheetAction(
          title: const Center(
            child: AppText(
              text: 'Take Photo',
              textSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          onPressed: (_) async {
            Get.back<void>();
            await _getImage(ImageSource.camera);
          },
        ),
      ],
      cancelAction: CancelAction(
        title: const AppText(
          text: 'Cancel',
          textAlign: TextAlign.center,
          textSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.error,
        ),
        onPressed: (_) => Get.back<void>(),
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final image = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1200,
    );
    if (image == null) return;

    callback.onSuccessFile(image.path, 'image');
  }

  void openAttachmentDialog() {}
}
