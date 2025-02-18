import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ResponsiveNum on num {
  double get height =>
      this *
      WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.height /
      100;
  double get w =>
      this *
      WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.width /
      100;
}

extension StringColorExtension on String {
  Color toColor() {
    if (isEmpty) return Colors.grey; // Default color for empty strings

    int hash = codeUnitAt(0); // Get ASCII value of the first character
    final Random random = Random(hash); // Seed random generator

    // Generate RGB values (ensuring bright colors)
    int r = 100 + random.nextInt(156);
    int g = 100 + random.nextInt(156);
    int b = 100 + random.nextInt(156);

    return Color.fromARGB(255, r, g, b);
  }
}

extension TimeOfDayExtensions on TimeOfDay {
  /// Convert TimeOfDay to 24-hour format string (e.g., "14:30:00")
  String to24HourFormat() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00';
  }

  String to12HourFormat() {
    final int hour =
        this.hour == 0 ? 12 : (this.hour > 12 ? this.hour - 12 : this.hour);
    final String period = this.hour >= 12 ? "PM" : "AM";
    final String minute = this.minute.toString().padLeft(2, '0');

    return "$hour:$minute $period";
  }
}

extension DateTimeFormatExtensions on String {
  String to12HourFormatDayOfTime() {
    try {
      final RegExp regex = RegExp(r'(\d+):(\d+):(\d+)');
      final match = regex.firstMatch(this);
      if (match == null) throw FormatException("Invalid time format: $this");

      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      String period = hour >= 12 ? "PM" : "AM";

      hour = hour % 12;
      if (hour == 0) hour = 12;

      return '$hour:${minute.toString().padLeft(2, '0')} $period';
    } catch (e) {
      return "";
    }
  }

  TimeOfDay? toTimeOfDay() {
    List<String> parts = split(":");
    if (parts.length >= 2) {
      // Ignore seconds if present
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } else {
      return null;
    }
  }
}


extension IsoStringToFormattedDate on String {
  String toFormattedDate() {
    DateTime dateTime = DateTime.parse(this);
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));

    if (DateFormat('yyyy-MM-dd').format(dateTime) == DateFormat('yyyy-MM-dd').format(now)) {
      return "Today";
    } else if (DateFormat('yyyy-MM-dd').format(dateTime) == DateFormat('yyyy-MM-dd').format(yesterday)) {
      return "Yesterday";
    } else {
      return DateFormat('dd-MMM-yyyy').format(dateTime);
    }
  }
}

