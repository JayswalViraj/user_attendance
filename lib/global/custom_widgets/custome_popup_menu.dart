import 'package:flutter/material.dart';

class CustomPopupMenu extends StatelessWidget {
  final Function(String) onSelected;

  const CustomPopupMenu({Key? key, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: "edit",
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.blue),
                SizedBox(width: 8),
                Text("Edit"),
              ],
            ),
          ),
          PopupMenuItem(
            value: "delete",
            child: Row(
              children: [
                Icon(Icons.delete, color: Colors.red),
                SizedBox(width: 8),
                Text("Delete"),
              ],
            ),
          ),

        ];
      },
    );
  }
}
