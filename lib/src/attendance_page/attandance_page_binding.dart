import 'package:get/get.dart';
import 'attandance_page_controller.dart';

class AttandancePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttandancePageController>(
      () => AttandancePageController(),
    );
  }
}
