import 'package:get/get.dart';

class Components {
  static void snackBar({required String title, String? message}) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
