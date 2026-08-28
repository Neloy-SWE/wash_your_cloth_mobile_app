/* 
Created by Neloy on 31 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../utilities/app_color.dart';

class CustomNotFound extends StatelessWidget {
  const CustomNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.not_interested,
        size: 50,
        color: AppColor.colorBackgroundCard,
      ),
    );
  }
}
