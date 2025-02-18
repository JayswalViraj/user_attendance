import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_attendance/global/models/users_model.dart';

import '../../global/services/local_storage/local_storage_sqflite/users_table.dart';

class UsersPageController extends GetxController {
  GlobalKey<FormState> titleFormKey = GlobalKey<FormState>();

  TextEditingController searchController = TextEditingController();

  RxList<UsersModel> users = <UsersModel>[].obs;
  RxInt totalCount = 0.obs;

  RxBool isLoading=false.obs;


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

    // called after the widget is rendered on screen
    // TODO: implement onReady

    await refreshUserList();
    super.onReady();
  }

  refreshUserList({String? searchText}) async {
    isLoading.value=true;
    users.clear();
    users.addAll(await UsersTable.getUsers(searchText: searchText));
    totalCount.value = await UsersTable.getUserCount();
    isLoading.value=false;

  }

  @override
  void onClose() {
    debugPrint("on close Method");
    // called just before the Controller is deleted from memory
    // TODO: implement onClose
    super.onClose();
  }
}
