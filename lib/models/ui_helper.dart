import 'package:flutter/material.dart';

class UiHelper {
  static void bottomSheet(BuildContext context){
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
      );
    },);
  }
}