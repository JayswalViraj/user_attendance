import 'package:get/get.dart';
import 'blank_page_controller.dart';

class BlankPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlankPageController>(
      () => BlankPageController(),
    );
  }
}
