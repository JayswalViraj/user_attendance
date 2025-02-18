import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_attendance/global/extentions/extentions.dart';

import '../../global/app_resources/app_colors.dart';
import '../../global/custom_widgets/custom_global_margin_widget.dart';
import '../../global/custom_widgets/custom_snackbar.dart';
import '../../global/custom_widgets/custom_text_form_field.dart';
import '../../global/global_functions/global_functions.dart';
import '../../global/models/users_model.dart';
import '../../global/services/local_storage/local_storage_sqflite/attandance_table.dart';
import '../../global/services/local_storage/local_storage_sqflite/users_table.dart';
import '../../global/utils/validator.dart';
import '../users_page/components.dart';
import '../users_page/users_page_view.dart';

Future<Map<String, dynamic>?> createEditTaskBottomSheet(
    {required BuildContext context,
    String? username,
    int? userId,
    int? taskId,
    TimeOfDay? inTime,
    TimeOfDay? outTime,
    String? absentDesc = ""}) async {
  final _usernameFormKey = GlobalKey<FormState>();
  final _inTimeFormKey = GlobalKey<FormState>();
  final _outTimeFormKey = GlobalKey<FormState>();
  final _absentDescFormKey = GlobalKey<FormState>();
  RxBool isAbsent = false.obs;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _inTimeController = TextEditingController();
  final TextEditingController _outTimeController = TextEditingController();
  final TextEditingController _absentDescController = TextEditingController();

  if (taskId != null) {
    _usernameController.text = username!;

    if (absentDesc!.length! < 3) {
      _inTimeController.text = inTime!.to12HourFormat();
      _outTimeController.text = outTime!.to12HourFormat();
    } else {
      _absentDescController.text = absentDesc ?? "";
      isAbsent.value = true;
    }
  }

  return await showModalBottomSheet<Map<String, dynamic>?>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return CustomGlobalMarginWidget(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 1.height,
            top: 2.height,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    taskId == null ? "Add Details" : "Update Details",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              SizedBox(height: 1.height),

              // Username Field
              Form(
                key: _usernameFormKey,
                child: CustomTextFormField(
                  label: "Select user",
                  readOnly: true,
                  onTap: () async {
                    UsersModel? selectedUser =
                        await selectUserBottomSheet(context: context);

                    if (selectedUser != null) {
                      debugPrint("usermodle: " + selectedUser!.username);
                      _usernameController.text = selectedUser!.username;
                      userId = selectedUser!.userId;
                      _usernameFormKey.currentState!.validate();
                    }
                  },
                  textEditingController: _usernameController,
                  onChanged: (value) {
                    _usernameFormKey.currentState!.validate();
                  },
                  validator: (value) {
                    return Validators.nameValidator(value);
                  },
                  hintText: 'Select user',
                ),
              ),
              SizedBox(height: 0.5.height),

              Obx(() {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.3.height),
                  child: Row(
                    children: [
                      Text(
                        "Is Absent?",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Checkbox(
                        value: isAbsent.value,
                        onChanged: (bool? newValue) {
                          isAbsent.value = newValue ?? false;
                        },
                      ),
                    ],
                  ),
                );
              }),

              Obx(() {
                return isAbsent.value
                    ? Column(
                        children: [
                          Form(
                            key: _absentDescFormKey,
                            child: CustomTextFormField(
                              maxLines: 3,
                              label: "Absent Description",
                              textEditingController: _absentDescController,
                              onChanged: (value) {
                                _absentDescFormKey.currentState!.validate();
                              },
                              validator: (value) {
                                return Validators.absentDescValidator(value);
                              },
                              hintText: 'Absent Description',
                            ),
                          ),
                          SizedBox(
                            width: 0.5.height,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Form(
                            key: _inTimeFormKey,
                            child: CustomTextFormField(
                              label: "In Time",
                              readOnly: true,
                              onTap: () async {
                                inTime = await GlobalFunction.pickTime(
                                    context, inTime ?? TimeOfDay.now());

                                if (inTime != null) {
                                  _inTimeController.text =
                                      inTime!.to12HourFormat();

                                  debugPrint("Time" + _inTimeController.text);
                                }
                                _inTimeFormKey.currentState!.validate();
                              },
                              textEditingController: _inTimeController,
                              onChanged: (value) {
                                _inTimeFormKey.currentState!.validate();
                              },
                              validator: (value) {
                                return Validators.inTimeValidator(inTime);
                              },
                              hintText: 'In Time',
                            ),
                          ),
                          SizedBox(
                            width: 0.5.height,
                          ),
                          Form(
                            key: _outTimeFormKey,
                            child: CustomTextFormField(
                              label: "Out Time",
                              readOnly: true,
                              onTap: () async {
                                outTime = await GlobalFunction.pickTime(
                                    context, outTime ?? TimeOfDay.now());

                                if (outTime != null) {
                                  _outTimeController.text =
                                      outTime!.to12HourFormat();

                                  debugPrint("Time" + _outTimeController.text);
                                }

                                _outTimeFormKey.currentState!.validate();
                              },
                              textEditingController: _outTimeController,
                              onChanged: (value) {
                                _outTimeFormKey.currentState!.validate();
                              },
                              validator: (value) {
                                return Validators.outTimeValidator(
                                    inTime, outTime);
                              },
                              hintText: 'Out Time',
                            ),
                          ),
                          SizedBox(height: 1.height),
                        ],
                      );
              }),

              SizedBox(height: 1.height,),

              ElevatedButton(
                onPressed: () async {
                  if (isAbsent.value) {
                    inTime = outTime = null;
                    bool userNameValidate =
                        _usernameFormKey.currentState!.validate();
                    bool absentDescValidate =
                        _absentDescFormKey.currentState!.validate();

                    if (userNameValidate && absentDescValidate) {
                      debugPrint("Successs");

                      if (taskId == null) {
                        AttendanceTable.insertAttendance(
                            absentDesc: _absentDescController.text,
                            userId: userId!,
                            createdDate: DateTime.now().toIso8601String(),
                            inTime: null,
                            outTime: null);
                      } else {
                        AttendanceTable.updateAttendance(
                            absentDesc: _absentDescController.text,
                            taskId: taskId,
                            userId: userId!,
                            inTime: null,
                            outTime: null);
                      }
                      Navigator.pop(context, {
                        "isSaved": true,
                      });
                      CustomSnackbar.showSuccess(
                          context, "Operation Successfully Completed! ✅");
                    } else {
                      debugPrint("Not Validate");
                    }
                  } else {
                    bool userNameValidate =
                        _usernameFormKey.currentState!.validate();
                    bool inTimeValidate =
                        _inTimeFormKey.currentState!.validate();
                    bool outTimeValidate =
                        _outTimeFormKey.currentState!.validate();

                    if (userNameValidate && inTimeValidate && outTimeValidate) {
                      debugPrint("Successs");
                      _absentDescController.clear();

                      if (taskId == null) {
                        AttendanceTable.insertAttendance(
                            absentDesc: _absentDescController.text,
                            userId: userId!,
                            createdDate: DateTime.now().toIso8601String(),
                            inTime: inTime!.to24HourFormat(),
                            outTime: outTime!.to24HourFormat());
                      } else {
                        AttendanceTable.updateAttendance(
                            absentDesc: _absentDescController.text,
                            taskId: taskId,
                            userId: userId!,
                            inTime: inTime!.to24HourFormat(),
                            outTime: outTime!.to24HourFormat());
                      }
                      Navigator.pop(context, {
                        "isSaved": true,
                      });
                      CustomSnackbar.showSuccess(
                          context, "Operation Successfully Completed! ✅");
                    } else {
                      debugPrint("Not Validate");
                    }
                  }
                },
                child: Text(
                  taskId == null ? "Create" : "Update",
                ),
              ),

              SizedBox(height: 1.height),
            ],
          ),
        ),
      );
    },
  );
}

Future<UsersModel?> selectUserBottomSheet(
    {required BuildContext context,
    String? username,
    String? mobileNo,
    int? userId}) async {
  final _usernameFormKey = GlobalKey<FormState>();
  RxList<UsersModel> users = <UsersModel>[].obs;
  RxInt totalCount = 0.obs;
  RxBool isLoading = false.obs;
  final TextEditingController _usernameController = TextEditingController();

  refreshUserList({String? searchText}) async {
    isLoading.value = true;
    users.clear();
    users.addAll(await UsersTable.getUsers(searchText: searchText));
    totalCount.value = await UsersTable.getUserCount();
    isLoading.value = false;
  }

  refreshUserList();

  return await showModalBottomSheet<UsersModel?>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Container(
        child: CustomGlobalMarginWidget(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 1.height,
              top: 2.height,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      "Select User",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                SizedBox(height: 1.height),

                // Username Field
                Form(
                  key: _usernameFormKey,
                  child: CustomTextFormField(
                    // label: "Search user",
                    textEditingController: _usernameController,
                    onChanged: (value) {
                      refreshUserList(searchText: value);
                    },

                    hintText: 'Search user...',
                  ),
                ),
                SizedBox(height: 0.7.height),
                Obx(() {
                  return users.isEmpty
                      ? isLoading.value
                          ? Flexible(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.3,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 5.height,
                                      child: CircularProgressIndicator(),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Flexible(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.3,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.not_interested,
                                      size: 5.height,
                                    ),
                                    SizedBox(
                                      height: 1.0.height,
                                    ),
                                    Text(
                                      "No Data Found",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    )
                                  ],
                                ),
                              ),
                            )
                      : Expanded(
                          child: Obx(() {
                            return ListView.separated(
                              shrinkWrap: true,
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  elevation: 1,
                                  child: Container(
                                    // color: AppColors.whiteColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(0.5.height),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context, users[index]);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Row(
                                                children: [
                                                  CircularCharacterWidget(
                                                    character:
                                                        users[index].username[0],
                                                    size: 3.height,
                                                  ),
                                                  SizedBox(
                                                    width: 0.8.height,
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          users[index].username,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .labelMedium,
                                                        ),
                                                        SizedBox(
                                                          height: 0.1.height,
                                                        ),
                                                        Text(users[index].mobileNo,
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .labelSmall)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 1.5.height,
                                );
                              },
                            );
                          }),
                        );
                }),

                SizedBox(height: 1.height),
              ],
            ),
          ),
        ),
      );
    },
  );
}
