import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'blank_page_controller.dart';

class BlankPageView extends GetView<BlankPageController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("Blank Page")),

          ElevatedButton(onPressed: () {}, child: Text("Home Page")),
        ],
      ),
    );
  }
}
