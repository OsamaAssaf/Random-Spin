import '../../../utils/all_imports.dart';

class Components {
  static void snackBar({required String content}) {
    Get.showSnackbar(
      GetSnackBar(
        message: content,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showLoading() {
    LoadingPlusController().show();
  }

  static void dismissLoading() {
    LoadingPlusController().dismiss();
  }

  static Center loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
