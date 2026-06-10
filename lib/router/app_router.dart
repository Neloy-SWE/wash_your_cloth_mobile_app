/* 
Created by Neloy on 18 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/auth/login/screen_auth_login.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/splash/screen_splash.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey();

class AppRouter {
  static const String screenSplash = "/screenSplash";
  static const String screenAuthLogin = "/screenAuthLogin";
  static const String screenAuthRegistration = "/screenAuthRegistration";
  static const String screenOTP = "/screenOTP";
}

final GoRouter appRouter = GoRouter(
  navigatorKey: navigator,
  initialLocation: AppRouter.screenSplash,
  routes: [
    GoRoute(
      path: AppRouter.screenSplash,
      builder: (context, state) => ScreenSplash(),
    ),
    GoRoute(
      path: AppRouter.screenAuthLogin,
      builder: (context, state) => ScreenAuthLogin(),
    ),
    // GoRoute(
    //   path: AppRouter.screenAuthRegistration,
    //   builder: (context, state) => ScreenAuthRegistration(),
    // ),
    // GoRoute(
    //   path: AppRouter.screenOTP,
    //   builder: (context, state) => ScreenOTP(),
    // ),
    // GoRoute(
    //   path: AppRouter.screenHomeBuyer,
    //   builder: (context, state) => ScreenHomeBuyer(),
    // ),
    // GoRoute(
    //   path: AppRouter.screenProfileBuyerEdit,
    //   builder: (context, state) => ScreenProfileBuyerEdit(),
    // ),
    // GoRoute(
    //   path: AppRouter.screenProfileUpdatePassword,
    //   builder: (context, state) => ScreenProfileUpdatePassword(),
    // ),
    // GoRoute(
    //   path: AppRouter.screenUpdateEmailPhone,
    //   builder: (context, state) => ScreenUpdateEmailPhone(),
    // ),
    // GoRoute(
    //   path: AppRouter.screenOrderDescription,
    //   builder: (context, state) => ScreenOrderDescription(),
    // ),
  ],
);
