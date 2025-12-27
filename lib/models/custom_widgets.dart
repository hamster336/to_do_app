import 'package:flutter/material.dart';

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
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20),
        foregroundColor: isSelected ? Colors.orange : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'Afacad',
          letterSpacing: 0.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
