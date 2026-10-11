/* 
Created by Neloy on 10 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../utilities/app_color.dart';
import '../../utilities/app_size.dart';
import '../../utilities/app_text.dart';

class CustomListHeader extends StatelessWidget {
  final String textListName;
  final VoidCallback onTap;
  final String textAddNewListName;

  const CustomListHeader({
    super.key,
    required this.textListName,
    required this.onTap,
    required this.textAddNewListName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(textListName, style: AppText.style.titleMedium),
        AppSize.gapW05,
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.colorBackgroundStatusPending,
              borderRadius: AppSize.borderRadiusAll8,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Text(
              textAddNewListName,
              style: AppText.style.bodyLarge!.copyWith(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
