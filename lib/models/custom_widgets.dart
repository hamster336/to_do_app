import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';

class CustomWidgets {
  // popUpMenu
  static PopupMenuItem<String> popUpMenuItem(String value, String text) {
    return PopupMenuItem(
      value: value,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  // filter buttons
  static ElevatedButton filterButtons({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required Size size,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 15),
        foregroundColor: isSelected
            ? const Color.fromARGB(255, 251, 140, 0)
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: size.shortestSide * 0.035,
          fontFamily: 'Afacad',
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static AlertDialog dialogBox({
    required BuildContext context,
    required String title,
    required String subtitle,
    required Function func,
  }) {
    return AlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: () => func, child: const Text('Yes')),
      ],
    );
  }

  // show date picker
  static Future<DateTime?> pickDueDate(BuildContext context, Task? task) async {
    final date = await showDatePicker(
      context: context,
      initialDate: task?.dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return null;

    return date;
  }
}
