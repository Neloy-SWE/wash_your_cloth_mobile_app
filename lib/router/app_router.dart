/* 
Created by Neloy on 18 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/bloc_global/global_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/auth/login/screen_auth_login.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/role/screen_role.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/splash/screen_splash.dart';

import '../presentation/screen/dashboard/screen_dashboard.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey();

class AppRouter {
  final GlobalBloc globalBloc;

  AppRouter({required this.globalBloc});

  static const String screenSplash = "/screenSplash";
  static const String screenRole = "/screenRole";
  static const String screenAuthLogin = "/screenAuthLogin";
  static const String screenAuthRegistration = "/screenAuthRegistration";
  static const String screenOTP = "/screenOTP";
  static const String screenDashboard = "/screenDashboard";

  late final GoRouter door = GoRouter(
    navigatorKey: navigator,
    initialLocation: AppRouter.screenSplash,
    refreshListenable: GoRouterRefreshStream(globalBloc.stream),
    redirect: (context, state) {
      final currentState = globalBloc.state;
      if (currentState.isLogin == null) {
        return screenSplash;
      } else if (currentState.isLogin == true) {
        return screenDashboard;
      }
      return screenRole;
    },
    routes: [
      GoRoute(
        path: AppRouter.screenSplash,
        builder: (context, state) => ScreenSplash(),
      ),
      GoRoute(
        path: AppRouter.screenRole,
        builder: (context, state) => ScreenRole(),
      ),
      GoRoute(
        path: AppRouter.screenAuthLogin,
        builder: (context, state) => ScreenAuthLogin(),
      ),
      GoRoute(
        path: AppRouter.screenDashboard,
        builder: (context, state) => ScreenDashboard(),
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
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
