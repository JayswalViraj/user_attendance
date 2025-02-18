import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class BlankPageController extends GetxController {
  @override
  void onInit() {

    debugPrint("on Init Method");
    // called immediately after the widget is allocated memory
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    debugPrint("on Ready Method");

    // called after the widget is rendered on screen
    // TODO: implement onReady

    super.onReady();
  }

  @override
  void onClose() {
    debugPrint("on close Method");
    // called just before the Controller is deleted from memory
    // TODO: implement onClose
    super.onClose();
  }
}
