/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../utilities/app_size.dart';
import '../../utilities/app_text.dart';

class CustomTitledDivider extends StatelessWidget {
  final String title;

  const CustomTitledDivider({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSize.gapH15,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Divider()),
            AppSize.gapW10,
            Text(title, style: AppText.style.bodyMedium),
            AppSize.gapW10,
            Expanded(child: Divider()),
          ],
        ),
        AppSize.gapH20,
      ],
    );
  }
}
