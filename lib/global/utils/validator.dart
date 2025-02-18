import 'package:flutter/material.dart';

class Validators {
  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter valid name";
    }
    return null;
  }

  static String? mobileNoValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Mobile number cannot be empty";
    } else if (value.length != 10) {
      return "Enter a valid 10-digit mobile number";
    }
    return null;
  }

  static String? inTimeValidator(TimeOfDay? value) {
    if (value == null) {
      return "Select In Time";
    } else {
      return null;
    }
  }

  static String? outTimeValidator(TimeOfDay? inTime, TimeOfDay? outTime) {
    if (outTime == null) return "Select Out Time";

    final inMinutes = inTime!.hour * 60 + inTime!.minute;
    final outMinutes = outTime!.hour * 60 + outTime!.minute;

    if (outMinutes <= inMinutes) {
      return "Out Time must be greater than In Time";
    }
    return null;
  }


  static String? absentDescValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter detail";
    } else if(value.trim().length<5){
      return "Please enter more then 5 charecters";
    }
    return null;
  }

}
