import 'package:flutter/material.dart';
import 'package:user_attendance/global/extentions/extentions.dart';

import '../../src/users_page/users_page_view.dart';

class AttendanceCard extends StatelessWidget {
  final String name;
  final String mobileNo;
  final String inTime;
  final String outTime;
  final bool isLate;
  final bool isEarly;
  final Widget popUpMenu;
  final String absentDesc;
  final bool isAbsent;

  const AttendanceCard({
    Key? key,
    required this.name,
    required this.mobileNo,
    required this.inTime,
    required this.outTime,
    this.isLate = false,
    this.isEarly = false,
    required this.popUpMenu,
    required this.absentDesc,
    this.isAbsent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(1.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name & Mobile with Popup Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildUserInfo(), popUpMenu],
            ),

            // In Time & Out Time
            absentDesc.length > 3
                ? SizedBox()
                : Column(
              children: [
                SizedBox(height: 1.height),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTimeInfo(Icons.access_time, "In Time", inTime,
                        Colors.green),
                    _buildTimeInfo(Icons.exit_to_app, "Out Time", outTime,
                        Colors.red),
                  ],
                ),
                SizedBox(height: 0.6.height),
              ],
            ),

            // Late Coming & Early Going Labels
            _buildLabels(),

            absentDesc.length > 3
                ? Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 0.6.height),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Reason:- "+ absentDesc,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                ))
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Flexible(
      child: Row(
        children: [
          CircularCharacterWidget(
            character: name[0],
            size: 3.height,
          ),
          SizedBox(width: 0.7.height,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(mobileNo, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<String>(
      onSelected: (value) => print("Selected: $value"),
      itemBuilder: (context) => [
        PopupMenuItem(value: "edit", child: Text("Edit")),
        PopupMenuItem(value: "delete", child: Text("Delete")),
        PopupMenuItem(value: "profile", child: Text("Profile")),
      ],
      icon: Icon(Icons.more_vert),
    );
  }

  Widget _buildTimeInfo(IconData icon, String label, String time, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600])),
            SizedBox(height: 2),
            Text(time,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Widget _buildLabels() {
    List<Widget> labels = [];
    if (isLate) {
      labels.add(_buildTag("Late Coming", Colors.orange));
    }
    if (isEarly) {
      labels.add(_buildTag("Early Going", Colors.blueAccent));
    }
    if (isAbsent) {
      labels.add(_buildTag("Absent", Colors.red));
    }
    return labels.isNotEmpty
        ? Padding(
      padding: EdgeInsets.only(top: 8),
      child: Row(
          children: labels,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly),
    )
        : SizedBox.shrink();
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text,
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}
