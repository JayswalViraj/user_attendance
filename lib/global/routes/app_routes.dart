import 'package:get/get.dart';
import 'package:user_attendance/src/attendance_page/attandance_page_view.dart';
import '../../src/attendance_page/attandance_page_binding.dart';
import '../../src/blank_page/blank_page_binding.dart';
import '../../src/blank_page/blank_page_view.dart';
import '../../src/dashboard_page/dashboard_page_binding.dart';
import '../../src/dashboard_page/dashboard_page_view.dart';
import '../../src/users_page/users_page_binding.dart';
import '../../src/users_page/users_page_view.dart';
import 'app_routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: AppRoutesName.blankPage,
          page: () => BlankPageView(),
          binding: BlankPageBinding(),
          transition: Transition.rightToLeftWithFade,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: AppRoutesName.dashboardPage,
          page: () => DashboardPageView(),
          binding: DashboardPageBinding(),
          transition: Transition.rightToLeftWithFade,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: AppRoutesName.usersPage,
          page: () => UsersPageView(),
          binding: UsersPageBinding(),
          transition: Transition.rightToLeftWithFade,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: AppRoutesName.attandancePage,
          page: () => AttandancePageView(),
          binding: AttandancePageBinding(),
          transition: Transition.rightToLeftWithFade,
          transitionDuration: Duration(milliseconds: 500),
        ),
      ];
}
