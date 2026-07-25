/* 
Created by Neloy on 19 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../utilities/app_color.dart';

class CustomIconFrame extends StatelessWidget {
  final double size;
  final IconData iconData;

  const CustomIconFrame({
    super.key,
    required this.size,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColor.colorBackgroundIconTop,
            AppColor.colorBackgroundIconBottom,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Icon(iconData, color: Colors.white, size: 30),
    );
  }
}
