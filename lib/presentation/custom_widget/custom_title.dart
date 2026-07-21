/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../utilities/app_asset.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_size.dart';

class CustomTitlePrimary extends StatelessWidget {
  final String title;
  final bool isRequired;
  final double fontSize;

  const CustomTitlePrimary({
    super.key,
    this.isRequired = true,
    required this.title,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Text(
                title,
                // style: AppText.style.titleSmall!.copyWith(fontSize: fontSize),
                style: TextStyle(
                  fontFamily: AppAsset.fontMedium,
                  color: Colors.black,
                  fontSize: fontSize,
                ),
              ),
              isRequired ? AppSize.gapW05 : AppSize.noGap,
              isRequired
                  ? Text(
                      "*",
                      style: TextStyle(
                        fontFamily: AppAsset.fontMedium,
                        color: AppColor.colorDanger,
                        fontSize: fontSize,
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

class CustomTitleWithIconValue extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconData;
  // final Color colorIcon;
  final Color colorTitle;
  final Color colorValue;
  final double sizeIcon;
  final double sizeFontTitle;
  final double sizeFontValue;

  const CustomTitleWithIconValue({
    super.key,
    required this.title,
    required this.iconData,
    // this.colorIcon = Colors.black,
    this.colorTitle = AppColor.colorPrimary,
    this.colorValue = Colors.black,
    this.sizeIcon = 16,
    this.sizeFontTitle = 14,
    this.sizeFontValue = 15,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppSize.gapW05,
            // Icon(iconData, color: colorIcon, size: sizeIcon),
            Icon(iconData, color: colorTitle, size: sizeIcon),
            AppSize.gapW05,
            Text(
              title,
              style: TextStyle(
                fontFamily: AppAsset.fontMedium,
                color: colorTitle,
                fontSize: sizeFontTitle,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: AppAsset.fontRegular,
            color: colorValue,
            fontSize: sizeFontValue,
          ),
        ),
      ],
    );
  }
}
