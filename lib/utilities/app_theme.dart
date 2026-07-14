/* 
Created by Neloy on 20 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_asset.dart';
import 'app_color.dart';
import 'app_size.dart';

/// this class contain code about theme of this app.
class AppTheme {

  static final get = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColor.colorPrimary,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColor.colorPrimary,
      ),
      titleTextStyle: TextStyle(
        fontFamily: AppAsset.fontBold,
        color: Colors.white,
        fontSize: 22,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textSelectionTheme: .new(
      cursorColor: AppColor.colorPrimary,
      selectionColor: AppColor.colorPrimaryTextSelection,
      selectionHandleColor: AppColor.colorPrimary,
    ),

    snackBarTheme: .new(
      // backgroundColor: AppColor.colorPrimary,
      shape: RoundedRectangleBorder(borderRadius: AppSize.borderRadiusAll10),
      contentTextStyle: TextStyle(
        fontFamily: AppAsset.fontRegular,
        fontSize: 12,
        color: Colors.white,
      ),
    ),
    radioTheme: .new(
      fillColor: WidgetStateColor.resolveWith((state) {
        if (state.contains(WidgetState.selected)) {
          return AppColor.colorPrimary;
        } else {
          return Colors.black;
        }
      }),
    ),

    segmentedButtonTheme: .new(
      style: SegmentedButton.styleFrom(
        textStyle: TextStyle(
          fontFamily: AppAsset.fontMedium,
          color: Colors.black,
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(borderRadius: AppSize.borderRadiusAll10),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        selectedBackgroundColor: AppColor.colorPrimary,
        selectedForegroundColor: Colors.white,
      ),
    ),

    navigationBarTheme: .new(
      labelPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      indicatorColor: Colors.white,
      elevation: 2,
      height: 65,
    ),

    textTheme: .new(
      titleLarge: TextStyle(
        fontFamily: AppAsset.fontBold,
        color: AppColor.colorPrimary,
        fontSize: 25,
      ),

      titleMedium: TextStyle(
        fontFamily: AppAsset.fontBold,
        color: Colors.black,
        fontSize: 18,
      ),

      titleSmall: TextStyle(
        fontFamily: AppAsset.fontMedium,
        color: Colors.black,
        fontSize: 16,
      ),

      bodyMedium: TextStyle(
        fontFamily: AppAsset.fontRegular,
        color: Colors.black,
        fontSize: 14,
      ),

      bodySmall: TextStyle(
        fontFamily: AppAsset.fontMedium,
        color: AppColor.colorDanger,
        fontSize: 12,
      ),
    ),
  );
}
