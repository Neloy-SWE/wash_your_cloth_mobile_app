/* 
Created by Neloy on 19 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../utilities/app_color.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_text.dart';

class CustomStatusBadge extends StatelessWidget {
  final String status;
  final double fontSize;
  final bool isBorder;

  const CustomStatusBadge({
    super.key,
    required this.status,
    this.fontSize = 12,
    this.isBorder = true,
  });

  (Color colorBackground, Color colorBorder) _getColors(String statusString) {
    final orderStatus = Status.values.firstWhere(
      (e) => e.name.toLowerCase() == statusString.toLowerCase(),
      orElse: () => Status.pending,
    );

    return switch (orderStatus) {
      Status.pending => (
        AppColor.colorBackgroundStatusPending,
        AppColor.colorBorderStatusPending,
      ),
      Status.accepted => (
        AppColor.colorBackgroundStatusAccepted,
        AppColor.colorBorderStatusAccepted,
      ),
      Status.rejected || Status.close => (
        AppColor.colorBackgroundStatusRejected,
        AppColor.colorDanger,
      ),
      Status.open || Status.ready || Status.delivered => (
        AppColor.colorBackgroundStatusReady,
        AppColor.colorBorderStatusReady,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final (colorBackground, colorBorder) = _getColors(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: isBorder ? colorBorder : colorBackground),
      ),
      child: Text(
        status.toUpperCase(),
        textAlign: TextAlign.center,
        style: AppText.style.bodySmall!.copyWith(
          color: colorBorder,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
