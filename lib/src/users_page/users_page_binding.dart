import 'package:get/get.dart';
import 'users_page_controller.dart';

class UsersPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersPageController>(
      () => UsersPageController(),
    );
  }
}
