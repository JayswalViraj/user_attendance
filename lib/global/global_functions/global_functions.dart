// import 'package:flutter/material.dart';
//
// import '../services/local_storage_shared_pref/shared_pref.dart';
//

// loginApp(){
//   SharedPrefServices.boolSave(key: SharedPrefKeys.isLogin,value: true);
// }
//
// getSharedPref() async{
//
//  Constants.isLogin= await SharedPrefServices.boolGet(key:  SharedPrefKeys.isLogin)??false;
//
//  debugPrint("Constants.isLogin: "+Constants.isLogin.toString());
//
// }

import 'package:flutter/material.dart';
import 'package:user_attendance/global/extentions/extentions.dart';

class GlobalFunction{
 static Future<TimeOfDay?> pickTime(context,TimeOfDay? initialTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime??TimeOfDay.now(),
    );
    if (pickedTime != null) {
      return pickedTime;
    }
    return null;
  }
}