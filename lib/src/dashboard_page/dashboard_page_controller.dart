import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_attendance/global/app_resources/app_strings.dart';

import '../attendance_page/attandance_page_controller.dart';
import '../users_page/users_page_controller.dart';

class DashboardPageController extends GetxController {
  RxInt selectedBottomMenu = 0.obs;

  List<BottomNavigationBarItem> bottomList = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.task),
      label: AppStrings.attandance,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.supervised_user_circle_rounded),
      label:AppStrings.users,
    ),
  ];

  final UsersPageController usersPageController = Get.put(UsersPageController());

  final AttandancePageController attandancePageController = Get.put(AttandancePageController());

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
