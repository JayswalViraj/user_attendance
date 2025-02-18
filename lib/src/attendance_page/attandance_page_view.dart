import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_attendance/global/custom_widgets/custom_global_margin_widget.dart';
import 'package:user_attendance/global/extentions/extentions.dart';
import 'package:user_attendance/global/services/local_storage/local_storage_sqflite/attandance_table.dart';
import 'package:user_attendance/src/users_page/components.dart';
import '../../global/app_resources/app_colors.dart';
import '../../global/constants/constants.dart';
import '../../global/custom_widgets/attandance_card.dart';
import '../../global/custom_widgets/custom_text_form_field.dart';
import '../../global/custom_widgets/custome_popup_menu.dart';
import 'attandance_page_controller.dart';
import 'components.dart';

class AttandancePageView extends GetView<AttandancePageController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic data = await createEditTaskBottomSheet(context: context);

          if (data != null) {
            controller.refreshAttendanceList();
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
                    "Attendance (${controller.totalCount.value})",
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                }),
              ],
            ),
            SizedBox(
              height: 1.height,
            ),
            Text(
              "In Time & Out Time: " +
                  Constants.inTime.to12HourFormatDayOfTime() +
                  " & " +
                  Constants.outTime.to12HourFormatDayOfTime(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 1.3.height,
            ),
            Obx(
               () {
                return controller.attendances.isEmpty
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
                              await controller.refreshAttendanceList();
                            },
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: controller.attendances.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 0.0.height, bottom: 0.9.height),
                                      child: index == 0
                                          ? Container(
                                      //  margin:EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                  color:
                                                      Colors.grey.withOpacity(0.2),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(16))),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0.2.height,
                                                    horizontal: 0.6.height),
                                                child: Text(
                                                  controller.attendances[index]
                                                      .createdDate
                                                      .toFormattedDate(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color:
                                                              AppColors.blackColor),
                                                ),
                                              ),
                                            )
                                          : controller.attendances[index - 1]
                                                      .createdDate
                                                      .toFormattedDate() ==
                                                  controller.attendances[index]
                                                      .createdDate
                                                      .toFormattedDate()
                                              ? SizedBox()
                                              : Padding(
                                                padding:  EdgeInsets.only(top: 0.3.height),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(16))),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 0.1.height,
                                                          horizontal: 0.6.height),
                                                      child: Text(
                                                        controller.attendances[index]
                                                            .createdDate
                                                            .toFormattedDate(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .blackColor),
                                                      ),
                                                    ),
                                                  ),
                                              ),
                                    ),
                                    AttendanceCard(
                                      absentDesc:
                                          controller.attendances[index].absentDesc!,
                                      name: controller.attendances[index].userName!,
                                      mobileNo: "+91 " +
                                          controller.attendances[index].mobileNo!,
                                      inTime: controller.attendances[index].inTime
                                              ?.to12HourFormatDayOfTime() ??
                                          "",
                                      outTime: controller.attendances[index].outTime
                                              ?.to12HourFormatDayOfTime() ??
                                          "",
                                      isLate: controller.attendances[index]
                                                  .absentDesc!.length <
                                              3
                                          ? controller.isTimeGreater(
                                                  controller.attendances[index]
                                                          .inTime ??
                                                      "",
                                                  Constants.inTime)
                                              ? true
                                              : false
                                          : false,
                                      isEarly: controller.attendances[index]
                                                  .absentDesc!.length <
                                              3
                                          ? controller.isTimeLess(
                                                  controller.attendances[index]
                                                          .outTime ??
                                                      "",
                                                  Constants.outTime)
                                              ? true
                                              : false
                                          : false,
                                      isAbsent: controller.attendances[index]
                                                  .absentDesc!.length >
                                              3
                                          ? true
                                          : false,
                                      popUpMenu: CustomPopupMenu(
                                        onSelected: (value) async {
                                          switch (value) {
                                            case 'edit':
                                              await createEditTaskBottomSheet(
                                                  context: context,
                                                  absentDesc: controller
                                                      .attendances[index]
                                                      .absentDesc,
                                                  taskId: controller
                                                      .attendances[index].taskId,
                                                  userId: controller
                                                      .attendances[index].userId,
                                                  username: controller
                                                      .attendances[index].userName,
                                                  inTime: controller
                                                      .attendances[index].inTime
                                                      ?.toTimeOfDay(),
                                                  outTime: controller
                                                      .attendances[index].outTime
                                                      ?.toTimeOfDay());
                                              controller.refreshAttendanceList();

                                              break;
                                            case 'delete':
                                              AttendanceTable.deleteAttendance(
                                                  controller
                                                      .attendances[index].taskId!);
                                              controller.refreshAttendanceList();
                                              break;

                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 0.3.height,
                                );
                              },
                            ),
                          );
                        }),
                      );
              }
            ),
          ],
        ),
      ),
    );
  }
}
