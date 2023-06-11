import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Components {
  static void snackBar({required String content}) {
    Get.showSnackbar(
      GetSnackBar(
        message: content,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static Center loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
