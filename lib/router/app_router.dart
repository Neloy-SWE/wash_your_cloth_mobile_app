/* 
Created by Neloy on 18 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_order.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/login/screen_login.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/otp/bloc/otp_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/otp/screen_otp.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/registration/bloc/registration_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/role/screen_role.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/shop/home/screen_home_shop.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/splash/screen_splash.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/cart/bloc/order_place_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/cart/screen_cart.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/home/screen_home_user.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/order/order_details/bloc/order_details_user_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/order/order_details/screen_order_details_user.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/order/order_list/bloc/order_list_user_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/profile/bloc/profile_view_user_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/shop/shop_details/screen_shop_details_user.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/shop/shop_list/bloc/shop_list_bloc.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_constant.dart';

import '../data/repository/repository_authentication.dart';
import '../data/repository/repository_profile.dart';
import '../data/repository/repository_shop.dart';
import '../data/use_case/order/use_case_order_place.dart';
import '../presentation/screen/authentication/login/bloc/login_bloc.dart';
import '../presentation/screen/authentication/registration/screen_registration.dart';
import '../presentation/screen/user/order/order_list/screen_order_list_user.dart';
import '../presentation/screen/user/profile/screen_profile_user.dart';
import '../presentation/screen/user/shop/shop_details/bloc/shop_details_user_bloc.dart';
import '../presentation/screen/user/shop/shop_list/screen_shop_list.dart';

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
  static const String screenOrderListUser = "/screenOrderListUser";
  static const String screenShopList = "/screenShopList";
  static const String screenOrderDetailsUser = "/screenOrderDetailsUser";
  static const String screenShopDetailsUser = "/screenShopDetailsUser";
  static const String screenProfileUser = "/ScreenProfileUser";
  static const String screenCart = "/screenCart";

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
            repositoryAuthentication: context.read<IRepositoryAuthentication>(),
          ),
          child: ScreenLogin(),
        ),
      ),
      GoRoute(
        path: AppRouter.screenOTP,
        builder: (context, state) => BlocProvider<OTPBloc>(
          create: (_) => OTPBloc(
            repositoryAuthentication: context.read<IRepositoryAuthentication>(),
          ),
          child: ScreenOTP(),
        ),
      ),

      GoRoute(
        path: AppRouter.screenRegistration,
        builder: (context, state) => BlocProvider<RegistrationBloc>(
          create: (_) => RegistrationBloc(
            repositoryAuthentication: context.read<IRepositoryAuthentication>(),
          ),
          child: ScreenRegistration(),
        ),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScreenHomeUser(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouter.screenOrderListUser,
                builder: (context, state) => const ScreenOrderListUser(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouter.screenShopList,
                builder: (context, state) => BlocProvider<ShopListBloc>(
                  create: (context) => ShopListBloc(
                    repositoryShop: context.read<IRepositoryShop>(),
                  )..add(ShopListEventFetch()),
                  child: const ScreenShopList(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouter.screenProfileUser,
                builder: (context, state) => BlocProvider<ProfileViewUserBloc>(
                  create: (context) => ProfileViewUserBloc(
                    repositoryProfile: context.read<IRepositoryProfile>(),
                  )..add(ProfileViewUserEventFetch()),
                  child: const ScreenProfileUser(),
                ),
              ),
            ],
          ),
        ],
      ),

      // GoRoute(
      //   path: AppRouter.screenHomeUser,
      //   builder: (context, state) => MultiBlocProvider(
      //     providers: [
      //       BlocProvider<OrderListUserBloc>(
      //         create: (context) => OrderListUserBloc(
      //           repositoryOrder: context.read<IRepositoryOrder>(),
      //         )..add(OrderListUserEventFetch()),
      //       ),
      //
      //       BlocProvider<ShopListBloc>(
      //         create: (context) =>
      //             ShopListBloc(repositoryShop: context.read<IRepositoryShop>())
      //               ..add(ShopListEventFetch()),
      //       ),
      //     ],
      //     child: ScreenHomeUser(),
      //   ),
      // ),
      GoRoute(
        path: AppRouter.screenOrderDetailsUser,
        builder: (context, state) {
          final orderId = state.extra as String;
          return BlocProvider<OrderDetailsUserBloc>(
            create: (context) => OrderDetailsUserBloc(
              repositoryOrder: context.read<IRepositoryOrder>(),
            )..add(OrderDetailsUserEventFetch(orderId: orderId)),
            child: ScreenOrderDetailsUser(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.screenHomeShop,
        builder: (context, state) => ScreenHomeShop(),
      ),

      GoRoute(
        path: AppRouter.screenShopDetailsUser,
        builder: (context, state) {
          final shopId = state.extra as String;
          return BlocProvider<ShopDetailsUserBloc>(
            create: (context) => ShopDetailsUserBloc(
              repositoryShop: context.read<IRepositoryShop>(),
            )..add(ShopDetailsUserEventFetch(shopId: shopId)),
            child: ScreenShopDetailsUser(),
          );
        },
      ),

      GoRoute(
        path: AppRouter.screenCart,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final shopId = extra[AppConstant.shopId] as String;
          final items = extra[AppConstant.items] as List<CartData>;
          final deliveryCharge = extra[AppConstant.deliveryCharge] as double;
          return BlocProvider<OrderPlaceBloc>(
            create: (context) => OrderPlaceBloc(
              repositoryOrder: context.read<IRepositoryOrder>(),
            ),
            child: ScreenCart(
              shopId: shopId,
              items: items,
              deliveryCharge: deliveryCharge,
            ),
          );
        },
      ),
    ],
  );
}
