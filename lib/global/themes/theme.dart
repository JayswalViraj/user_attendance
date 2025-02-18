import 'package:flutter/material.dart';
import 'package:user_attendance/global/app_resources/app_colors.dart';

class CustomTheme {
  static ThemeData getTheme(BuildContext context) {
    // Access context-based values like MediaQuery or Localization if necessary

    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.orange,
      brightness: Brightness.light,
      buttonTheme: ButtonThemeData(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            Size(
              MediaQuery.of(context).size.width * 0.9, // 90% of screen width
              MediaQuery.of(context).size.height * 0.06, // 6% of screen height
            ),
          ),
          backgroundColor:
              MaterialStateProperty.all(Colors.lime), // Button color
          foregroundColor:
              MaterialStateProperty.all(Colors.white), // Text color
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
          ),
          elevation: MaterialStateProperty.all(5),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        displayMedium: TextStyle(
            fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black),
        displaySmall: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
        headlineMedium: TextStyle(
            fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
        headlineSmall: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        titleLarge: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        titleSmall: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        bodyLarge: TextStyle(
            fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
        bodyMedium: TextStyle(
            fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
        bodySmall: TextStyle(
            fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black),
        labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor),
        labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor),
        labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: Colors.grey.withOpacity(0.5),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: AppColors.gray),
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(15), // Rounded corners for enabled state
          borderSide: BorderSide(
            color: Colors.grey
                .withOpacity(0.5), // Light gray border for the disabled state
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(15), // Rounded corners for enabled state
          borderSide: BorderSide(
            color: Colors.grey
                .withOpacity(0.5), // Light gray border for the disabled state
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(15), // Rounded corners for enabled state
          borderSide: BorderSide(
            color: Colors.grey
                .withOpacity(0.5), // Light gray border for the disabled state
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
