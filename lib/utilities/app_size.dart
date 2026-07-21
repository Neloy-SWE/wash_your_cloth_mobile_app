/* 
Created by Neloy on 18 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

class AppSize {
  // no gap:
  static const SizedBox noGap = SizedBox();

  // height:
  static const SizedBox gapH05 = SizedBox(height: 05);
  static const SizedBox gapH10 = SizedBox(height: 10);
  static const SizedBox gapH15 = SizedBox(height: 15);
  static const SizedBox gapH20 = SizedBox(height: 20);
  static const SizedBox gapH35 = SizedBox(height: 35);
  static const SizedBox gapH50 = SizedBox(height: 50);
  static const SizedBox gapH80 = SizedBox(height: 80);
  static const SizedBox gapH150 = SizedBox(height: 150);

  // width:
  static const SizedBox gapW05 = SizedBox(width: 05);
  static const SizedBox gapW10 = SizedBox(width: 10);
  static const SizedBox gapW15 = SizedBox(width: 15);
  static const SizedBox gapW20 = SizedBox(width: 20);

  // padding:
  static const EdgeInsets paddingAll25 = EdgeInsets.all(25);
  static const EdgeInsets paddingAll10 = EdgeInsets.all(10);

  // border:
  static BorderRadius get borderRadiusAll8 => .circular(8);
  static BorderRadius get borderRadiusAll10 => .circular(10);
}