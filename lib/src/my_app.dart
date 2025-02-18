import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:user_attendance/global/routes/app_routes.dart';
import 'package:user_attendance/global/routes/app_routes_name.dart';

import '../global/themes/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutesName.dashboardPage,
      getPages: AppRoutes.appRoutes(),
      title: 'Flutter Demo',
      theme: CustomTheme.getTheme(context),
    );
  }
}
