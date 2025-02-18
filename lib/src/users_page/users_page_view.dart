import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_attendance/global/custom_widgets/custom_global_margin_widget.dart';
import 'package:user_attendance/global/custom_widgets/custom_text_form_field.dart';
import 'package:user_attendance/global/extentions/extentions.dart';
import 'package:user_attendance/src/attendance_page/attandance_page_controller.dart';
import 'package:user_attendance/src/users_page/components.dart';
import '../../global/app_resources/app_colors.dart';
import '../../global/custom_widgets/custom_snackbar.dart';
import '../../global/custom_widgets/custome_popup_menu.dart';
import '../../global/services/local_storage/local_storage_sqflite/users_table.dart';
import 'users_page_controller.dart';

class UsersPageView extends GetView<UsersPageController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic>? data =
              await createEditUserBottomSheet(context: context);

          debugPrint("Data: " + data.toString());

          if (data != null) {
            if (data["isSaved"] == true) {
              await controller.refreshUserList();
            }
          }
        },
        child: Icon(Icons.add),
      ),
      body: CustomGlobalMarginWidget(
        child: Column(
          children: [
            SizedBox(
              height: 2.2.height,
            ),
            Row(
              children: [
                Obx(() {
                  return Text(
                    "Users (${controller.totalCount.value})",
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                }),
              ],
            ),
            SizedBox(
              height: 1.height,
            ),
            CustomTextFormField(
              textEditingController: controller.searchController,
              hintText: "Search by username and mobile no...",
              onChanged: (value) {
                controller.refreshUserList(searchText: value);
              },
            ),
            Obx(() {
              return controller.users.isEmpty
                  ? controller.isLoading.value
                      ? Flexible(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 1.3,
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
                            height: MediaQuery.of(context).size.height / 1.3,
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
                                  style: Theme.of(context).textTheme.titleLarge,
                                )
                              ],
                            ),
                          ),
                        )
                  : Expanded(
                      child: Obx(() {
                        return RefreshIndicator(
                          onRefresh: () async {
                            await controller.refreshUserList();
                          },
                          child: ListView.separated(
                            shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.users.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                elevation: 1,
                                child: Container(
                                  //  color: AppColors.whiteColor,
                                  child: Padding(
                                    padding: EdgeInsets.all(0.5.height),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Row(
                                            children: [
                                              CircularCharacterWidget(
                                                character: controller
                                                    .users[index].username[0],
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
                                                      controller
                                                          .users[index].username,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium,
                                                    ),
                                                    SizedBox(
                                                      height: 0.1.height,
                                                    ),
                                                    Text(
                                                        controller
                                                            .users[index].mobileNo,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CustomPopupMenu(
                                          onSelected: (value) async {
                                            switch (value) {
                                              case 'edit':

                                                debugPrint(controller
                                                    .users[index].userId
                                                    .toString());

                                                Map<String, dynamic>? data =
                                                    await createEditUserBottomSheet(
                                                        context: context,
                                                        userId: controller
                                                            .users[index]
                                                            .userId,
                                                        username: controller
                                                            .users[index]
                                                            .username,
                                                        mobileNo: controller
                                                            .users[index]
                                                            .mobileNo);

                                                debugPrint(
                                                    "Data: " + data.toString());

                                                if (data != null) {
                                                  if (data["isSaved"] == true) {
                                                    await controller
                                                        .refreshUserList();
                                                    CustomSnackbar.showSuccess(
                                                        context, "Operation Successfully Completed! ✅");
                                                  }
                                                }
                                                break;
                                              case 'delete':
                                                UsersTable.deleteUser(
                                                  controller
                                                      .users[index].userId!,
                                                );
                                                controller.refreshUserList();
                                                AttandancePageController attandancePageConroller= Get.find();
                                                attandancePageConroller.refreshAttendanceList();
                                                CustomSnackbar.showSuccess(
                                                    context, "Operation Successfully Completed! ✅");
                                                break;

                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 0.7.height,
                              );
                            },
                          ),
                        );
                      }),
                    );
            }),
          ],
        ),
      ),
    );
  }
}

class CircularCharacterWidget extends StatelessWidget {
  final String character;
  final double size;
  final Color backgroundColor;
  final Color textColor;

  const CircularCharacterWidget({
    Key? key,
    required this.character,
    this.size = 60.0, // Default size
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: character.toColor(),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(character, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
