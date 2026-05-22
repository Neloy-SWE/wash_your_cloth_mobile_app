/* 
Created by Neloy on 20 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColor.colorPrimary,
      body: Center(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
