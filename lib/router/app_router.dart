/* 
Created by Neloy on 18 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/order/api_get_order_details_user.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/order/i_api_get_order_list.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_order.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/login/screen_login.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/otp/bloc/otp_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/otp/screen_otp.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/registration/bloc/registration_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/role/screen_role.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/shop/home/screen_home_shop.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/splash/screen_splash.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/home/screen_home_user.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/order/order_details/bloc/order_details_user_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/order/order_details/screen_order_details_user.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/order/order_list/bloc/order_list_user_bloc.dart';

import '../data/client/client.dart';
import '../data/repository/repository_authentication.dart';
import '../presentation/screen/authentication/login/bloc/login_bloc.dart';
import '../presentation/screen/authentication/registration/screen_registration.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey();

class AppRouter {
  // final GlobalBloc globalBloc;
  //
  // AppRouter({required this.globalBloc});

  static const String screenSplash = "/screenSplash";
  static const String screenRole = "/screenRole";
  static const String screenLogin = "/screenLogin";
  static const String screenRegistration = "/screenRegistration";
  static const String screenOTP = "/screenOTP";
  static const String screenHomeUser = "/screenHomeUser";
  static const String screenHomeShop = "/screenHomeShop";
  static const String screenOrderDetailsUser = "/screenOrderDetailsUser";

  static final GoRouter door = GoRouter(
    navigatorKey: navigator,
    initialLocation: AppRouter.screenSplash,
    // refreshListenable: GoRouterRefreshStream(globalBloc.stream),
    // redirect: (context, state) {
    //   final currentState = globalBloc.state;
    //   if (currentState.isLogin == null) {
    //     return screenSplash;
    //   } else if (currentState.isLogin == true) {
    //     return screenDashboard;
    //   }
    //   else if (currentState.isLogin == false){
    //     return screenRole;
    //   }
    //   return null;
    // },
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
        path: AppRouter.screenLogin,
        builder: (context, state) => BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(
            repositoryAuthentication:
                RepositoryProvider.of<IRepositoryAuthentication>(context),
          ),
          child: ScreenLogin(),
        ),
      ),
      GoRoute(
        path: AppRouter.screenOTP,
        builder: (context, state) => BlocProvider<OTPBloc>(
          create: (_) => OTPBloc(
            repositoryAuthentication:
                RepositoryProvider.of<IRepositoryAuthentication>(context),
          ),
          child: ScreenOTP(),
        ),
      ),

      GoRoute(
        path: AppRouter.screenRegistration,
        builder: (context, state) => BlocProvider<RegistrationBloc>(
          create: (_) => RegistrationBloc(
            repositoryAuthentication:
                RepositoryProvider.of<IRepositoryAuthentication>(context),
          ),
          child: ScreenRegistration(),
        ),
      ),
      GoRoute(
        path: AppRouter.screenHomeUser,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<OrderListUserBloc>(
              create: (context) => OrderListUserBloc(
                repositoryOrder: RepositoryProvider.of<IRepositoryOrder>(
                  context,
                ),
              )..add(OrderListUserEventFetch()),
            ),
          ],
          child: ScreenHomeUser(),
        ),
      ),

      GoRoute(
        path: AppRouter.screenOrderDetailsUser,
        builder: (context, state) {
          final orderId = state.extra as String;
          return BlocProvider<OrderDetailsUserBloc>(
            create: (context) => OrderDetailsUserBloc(
              repositoryOrder: RepositoryProvider.of<IRepositoryOrder>(context),
            )..add(OrderDetailsUserEventFetch(orderId: orderId)),
            child: ScreenOrderDetailsUser(),
          );
        },
      ),

      GoRoute(
        path: AppRouter.screenHomeShop,
        builder: (context, state) => ScreenHomeShop(),
      ),
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
