import 'dart:convert';
import 'package:flutter/material.dart';

Widget customListTile({
  required String title,
  required String path,
  required String date,
  required String image,
  required VoidCallback onTap,
  required bool isDone,
  required String type,
  Widget? subtitleWidget, // ✅ New parameter
  double price = 0.0,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 115, 115, 115),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Path & status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(path, style: TextStyle(fontSize: 12)),
              if (type != 'Upcoming')
                Row(
                  children: [
                    Text(
                      isDone ? 'Done' : 'Active',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      isDone ? Icons.check_circle : Icons.hourglass_top,
                      color: isDone ? Colors.green : Colors.red,
                      size: 12,
                    ),
                  ],
                ),
            ],
          ),

          // Info
          ListTile(
            leading: Image.memory(base64Decode(image), height: 60),
            title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: subtitleWidget ?? const SizedBox(), // ✅ Render custom widget
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Cost Negotiable',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          if (type == 'Inprocess')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {}, // job done logic
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 212, 190, 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 150,
                    child: Text(
                      'Job Done',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),

          if (type == 'Upcoming')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {}, // cancel logic
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 150,
                    child: Text(
                      'Cancel Job',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    ),
  );
}
