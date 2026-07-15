/* 
Created by Neloy on 20 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/services.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_constant.dart';

class AppToolSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.replaceAll(RegExp(r' {2,}'), ' ');

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

/// order status color select
List<Color> getStatusBadgeColorSet({required String orderStatus}) {
  List<Color> colorSet = [];
  final status = OrderStatus.values.byName(orderStatus);
  switch (status) {
    case OrderStatus.pending:
      colorSet.addAll([
        AppColor.colorBackgroundStatusPending,
        AppColor.colorBorderStatusPending,
      ]);
    case OrderStatus.accepted:
      colorSet.addAll([
        AppColor.colorBackgroundStatusAccepted,
        AppColor.colorBorderStatusAccepted,
      ]);
    default:
      colorSet = [];
  }

  return colorSet;
}
