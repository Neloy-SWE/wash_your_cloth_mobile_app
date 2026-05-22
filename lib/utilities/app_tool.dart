/* 
Created by Neloy on 20 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/services.dart';

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
