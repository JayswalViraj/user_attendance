import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:user_attendance/global/custom_widgets/custom_global_margin_widget.dart';
import 'package:user_attendance/global/custom_widgets/custom_snackbar.dart';
import 'package:user_attendance/global/extentions/extentions.dart';
import 'package:user_attendance/global/global_functions/global_functions.dart';
import 'package:user_attendance/global/models/attandance_model.dart';
import 'package:user_attendance/global/models/users_model.dart';
import 'package:user_attendance/global/services/local_storage/local_storage_sqflite/attandance_table.dart';
import 'package:user_attendance/global/utils/validator.dart';
import 'package:user_attendance/src/users_page/users_page_view.dart';

import '../../global/app_resources/app_colors.dart';
import '../../global/custom_widgets/custom_text_form_field.dart';
import '../../global/custom_widgets/custome_popup_menu.dart';
import '../../global/services/local_storage/local_storage_sqflite/users_table.dart';

Future<Map<String, dynamic>?> createEditUserBottomSheet(
    {required BuildContext context,
    String? username,
    String? mobileNo,
    int? userId}) async {
  final _usernameFormKey = GlobalKey<FormState>();
  final _mobileNoFormKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  userId;

  if (userId != null) {
    _usernameController.text = username!;
    _mobileController.text = mobileNo!;
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
                    userId == null ? "Create a new user" : "Update user",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              SizedBox(height: 1.height),

              // Username Field
              Form(
                key: _usernameFormKey,
                child: CustomTextFormField(
                  label: "Name",
                  textEditingController: _usernameController,
                  onChanged: (value) {
                    _usernameFormKey.currentState!.validate();
                  },
                  validator: (value) {
                    return Validators.nameValidator(value);
                  },
                  hintText: 'Name',
                ),
              ),
              SizedBox(height: 0.5.height),

              Form(
                key: _mobileNoFormKey,
                child: CustomTextFormField(
                  label: "Mobile No",
                  keyboardType: TextInputType.phone,
                  textEditingController: _mobileController,
                  textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    _mobileNoFormKey.currentState!.validate();
                  },
                  validator: (value) {
                    return Validators.mobileNoValidator(value);
                  },
                  hintText: 'Mobile No',
                ),
              ),

              SizedBox(height: 1.3.height),

              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  bool userValidate = _usernameFormKey.currentState!.validate();
                  bool mobileNoValidate =
                      _mobileNoFormKey.currentState!.validate();

                  if (userValidate && mobileNoValidate) {
                    // Insert a user
                    if (userId == null) {
                      await UsersTable.insertUser(UsersModel(
                        username: _usernameController.text,
                        mobileNo: _mobileController.text,
                        createdDate: DateTime.now().toIso8601String(),
                      ));
                    } else {
                      await UsersTable.updateUser(
                          userId: userId,
                          username: _usernameController.text,
                          mobileNo: _mobileController.text);
                    }

                    Navigator.pop(context, {
                      "isSaved": true,
                    });

                    CustomSnackbar.showSuccess(
                        context, "Operation Successfully Completed! ✅");
                  }
                },
                child: Text(
                  userId == null ? "Create" : "Update",
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
