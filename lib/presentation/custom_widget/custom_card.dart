/* 
Created by Neloy on 01 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';

import '../../utilities/app_size.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color colorBackground;
  final Color colorBorder;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = AppSize.paddingAll10,
    this.colorBackground = Colors.white,
    this.colorBorder = AppColor.colorBorderCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class CustomCardWithAction extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color colorBackground;
  final Color colorBorder;

  const CustomCardWithAction({
    super.key,
    required this.onTap,
    required this.child,
    this.colorBackground = Colors.white,
    this.colorBorder = AppColor.colorBorderCard,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSize.borderRadiusAll10,
      child: CustomCard(
        colorBorder: colorBorder,
        colorBackground: colorBackground,
        child: child,
      ),
    );
  }
}
