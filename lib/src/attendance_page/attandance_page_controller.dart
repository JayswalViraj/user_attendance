import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_attendance/global/services/local_storage/local_storage_sqflite/attandance_table.dart';

import '../../global/models/attandance_model.dart';

class AttandancePageController extends GetxController {
  RxList<AttendanceModel> attendances = <AttendanceModel>[].obs;
  RxInt totalCount = 0.obs;

  TextEditingController searchController = TextEditingController();

  RxBool isLoading=false.obs;

  refreshAttendanceList({String? searchText}) async {
    isLoading.value=true;
    attendances.clear();
    attendances.addAll(await AttendanceTable.getAttendanceWithUsers());
    totalCount.value = await AttendanceTable.getAttandanceCount();
    isLoading.value=false;

    debugPrint("total"+totalCount.value.toString());
  }
  bool isTimeGreater(String t1, String t2) => t1.compareTo(t2) > 0;
  bool isTimeLess(String t1, String t2) => t1.compareTo(t2) < 0;

  @override
  void onInit() {
    debugPrint("on Init Method");
    // called immediately after the widget is allocated memory
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    debugPrint("on Ready Method");
    await refreshAttendanceList();

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
