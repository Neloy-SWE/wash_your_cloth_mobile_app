/* 
Created by Neloy on 19 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../utilities/app_text.dart';

class CustomStatusBadge extends StatelessWidget {
  final List<Color> statusColorSet;
  final String status;
  final double fontSize;
  const CustomStatusBadge({super.key, required this.statusColorSet, required this.status, this.fontSize = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: statusColorSet[0],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: statusColorSet[1]),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppText.style.bodySmall!.copyWith(
          color: statusColorSet[1],
          fontSize: fontSize,
        ),
      ),
    );
  }
}
