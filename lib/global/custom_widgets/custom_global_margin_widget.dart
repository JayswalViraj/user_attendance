import 'package:flutter/material.dart';
import 'package:user_attendance/global/extentions/extentions.dart';

class CustomGlobalMarginWidget extends StatelessWidget {
  CustomGlobalMarginWidget({super.key, required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 1.7.height,
      ),
      child: child,
    );
  }
}
