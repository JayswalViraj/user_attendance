import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_attendance/src/users_page/users_page_view.dart';
import '../attendance_page/attandance_page_view.dart';
import 'dashboard_page_controller.dart';

class DashboardPageView extends GetView<DashboardPageController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.selectedBottomMenu.value,
          onTap: (value) {
            controller.selectedBottomMenu.value = value;
          },
          items: controller.bottomList,
        );
      }),
      body: Obx(
         () {
          return Column(
            children: [
              if (controller.selectedBottomMenu.value == 0) ...[
                Expanded(child: AttandancePageView()),
              ] else ...[
                Expanded(child: UsersPageView())
              ]
            ],
          );
        }
      ),
    );
  }
}
