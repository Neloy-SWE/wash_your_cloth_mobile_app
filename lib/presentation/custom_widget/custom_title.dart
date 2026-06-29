/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../utilities/app_color.dart';
import '../../utilities/app_size.dart';
import '../../utilities/app_text.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final bool isRequired;

  const CustomTitle({super.key, this.isRequired = true, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Text(title, style: AppText.style.titleSmall),
              isRequired ? AppSize.gapW05 : AppSize.noGap,
              isRequired
                  ? Text(
                "*",
                style: AppText.style.titleSmall!.copyWith(
                  color: AppColor.colorDanger,
                ),
              )
                  : AppSize.noGap,
            ],
          ),
        ),
        AppSize.gapH10,
      ],
    );
  }
}