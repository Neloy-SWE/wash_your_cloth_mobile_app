/* 
Created by Neloy on 11 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../utilities/app_color.dart';

class CustomSnackBar {
  static void primary({
    required BuildContext context,
    required String contentText,
    Color backgroundColor = AppColor.colorPrimary,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(contentText),
        behavior: SnackBarBehavior.floating,
        margin: .only(left: 30, right: 30, bottom: 50),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      ),
    );
  }
}
