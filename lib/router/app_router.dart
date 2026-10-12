/* 
Created by Neloy on 18 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../data/repository/repository_authentication.dart';
import '../data/repository/repository_order.dart';
import '../data/repository/repository_profile.dart';
import '../data/repository/repository_shop.dart';
import '../data/repository/repository_shop_inventory.dart';
import '../data/use_case/order/use_case_order_place.dart';
import '../presentation/screen/authentication/change_password/bloc/change_password_bloc.dart';
import '../presentation/screen/authentication/change_password/screen_change_password.dart';
import '../presentation/screen/authentication/change_phone/bloc/change_phone_bloc.dart';
import '../presentation/screen/authentication/change_phone/screen_change_phone.dart';
import '../presentation/screen/authentication/login/bloc/login_bloc.dart';
import '../presentation/screen/authentication/login/screen_login.dart';
import '../presentation/screen/authentication/otp/bloc/otp_bloc.dart';
import '../presentation/screen/authentication/otp/screen_otp.dart';
import '../presentation/screen/authentication/registration/bloc/registration_bloc.dart';
import '../presentation/screen/authentication/registration/screen_registration.dart';
import '../presentation/screen/role/screen_role.dart';
import '../presentation/screen/shop/home/screen_home_shop.dart';
import '../presentation/screen/shop/inventory/price/price_add/screen_price_add.dart';
import '../presentation/screen/shop/inventory/price/price_list/bloc/price_list_shop_bloc.dart';
import '../presentation/screen/shop/inventory/price/price_list/screen_price_list.dart';
import '../presentation/screen/shop/inventory/price/price_update/bloc/price_update_bloc.dart';
import '../presentation/screen/shop/inventory/price/price_update/screen_price_update.dart';
import '../presentation/screen/shop/inventory/service/service_list/bloc/service_list_bloc.dart';
import '../presentation/screen/shop/inventory/service/service_list/screen_service_list.dart';
import '../presentation/screen/shop/inventory/service/service_update/bloc/service_update_bloc.dart';
import '../presentation/screen/shop/inventory/service/service_update/screen_service_update.dart';
import '../presentation/screen/shop/order/order_details/bloc/order_details_shop_bloc.dart';
import '../presentation/screen/shop/order/order_details/screen_order_details_shop.dart';
import '../presentation/screen/shop/order/order_list/screen_order_list_shop.dart';
import '../presentation/screen/shop/profile/update/bloc/profile_update_shop_bloc.dart';
import '../presentation/screen/shop/profile/update/screen_profile_update_shop.dart';
import '../presentation/screen/shop/profile/view/bloc/profile_view_shop_bloc.dart';
import '../presentation/screen/shop/profile/view/screen_profile_shop.dart';
import '../presentation/screen/splash/screen_splash.dart';
import '../presentation/screen/user/cart/bloc/order_place_bloc.dart';
import '../presentation/screen/user/cart/screen_cart.dart';
import '../presentation/screen/user/home/screen_home_user.dart';
import '../presentation/screen/user/order/order_details/bloc/order_details_user_bloc.dart';
import '../presentation/screen/user/order/order_details/screen_order_details_user.dart';
import '../presentation/screen/user/order/order_list/screen_order_list_user.dart';
import '../presentation/screen/user/profile/update/bloc/profile_update_user_bloc.dart';
import '../presentation/screen/user/profile/update/screen_profile_update_user.dart';
import '../presentation/screen/user/profile/view/bloc/profile_view_user_bloc.dart';
import '../presentation/screen/user/profile/view/screen_profile_user.dart';
import '../presentation/screen/user/shop/shop_details/bloc/shop_details_user_bloc.dart';
import '../presentation/screen/user/shop/shop_details/screen_shop_details_user.dart';
import '../presentation/screen/user/shop/shop_list/bloc/shop_list_bloc.dart';
import '../presentation/screen/user/shop/shop_list/screen_shop_list.dart';
import '../utilities/app_constant.dart';

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
  static const String screenOrderDetailsShop = "/screenOrderDetailsShop";
  static const String screenShopDetailsUser = "/screenShopDetailsUser";
  static const String screenProfileUser = "/ScreenProfileUser";
  static const String screenCart = "/screenCart";
  static const String screenProfileUpdateUser = "/screenProfileUpdateUser";
  static const String screenChangePassword = "/screenChangePassword";
  static const String screenChangePhone = "/screenChangePhone";
  static const String screenOrderListShop = "/screenOrderListShop";
  static const String screenProfileShop = "/screenProfileShop";
  static const String screenProfileUpdateShop = "/screenProfileUpdateShop";
  static const String screenPriceList = "/screenPriceList";
  static const String screenPriceUpdate = "/screenPriceUpdate";
  static const String screenPriceAdd = "/screenPriceAdd";
  static const String screenServiceList = "/screenServiceList";
  static const String screenServiceUpdate = "/screenServiceUpdate";

  static final GoRouter door = GoRouter(
    navigatorKey: navigator,
    initialLocation: screenSplash,
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
      GoRoute(path: screenSplash, builder: (context, state) => ScreenSplash()),
      GoRoute(path: screenRole, builder: (context, state) => ScreenRole()),
      GoRoute(
        path: screenLogin,
        builder: (context, state) => BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(
            repositoryAuthentication: context.read<IRepositoryAuthentication>(),
          ),
          child: ScreenLogin(),
        ),
      ),
      GoRoute(
        path: screenOTP,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final otpRequestId = extra[AppConstant.otpRequestId] as String;
          final recordId = extra[AppConstant.recordId] as String;
          return BlocProvider<OTPBloc>(
            create: (_) => OTPBloc(
              repositoryAuthentication: context
                  .read<IRepositoryAuthentication>(),
            ),
            child: ScreenOTP(otpRequestId: otpRequestId, recordId: recordId),
          );
        },
      ),

      GoRoute(
        path: screenRegistration,
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
                path: screenOrderListUser,
                builder: (context, state) => const ScreenOrderListUser(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: screenShopList,
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
                path: screenProfileUser,
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
      //   path: screenHomeUser,
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
        path: screenOrderDetailsUser,
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

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScreenHomeShop(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: screenOrderListShop,
                builder: (context, state) => const ScreenOrderListShop(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: screenProfileShop,
                builder: (context, state) => BlocProvider<ProfileViewShopBloc>(
                  create: (context) => ProfileViewShopBloc(
                    repositoryProfile: context.read<IRepositoryProfile>(),
                  )..add(ProfileViewShopEventFetch()),
                  child: const ScreenProfileShop(),
                ),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: screenShopDetailsUser,
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
        path: screenCart,
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

      GoRoute(
        path: screenProfileUpdateUser,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final firstName = extra[AppConstant.firstName] as String;
          final lastName = extra[AppConstant.lastName] as String;
          final address = extra[AppConstant.address] as String;
          return BlocProvider<ProfileUpdateUserBloc>(
            create: (context) => ProfileUpdateUserBloc(
              repositoryProfile: context.read<IRepositoryProfile>(),
            ),
            child: ScreenProfileUpdateUser(
              firstName: firstName,
              lastName: lastName,
              address: address,
            ),
          );
        },
      ),

      GoRoute(
        path: screenChangePassword,
        builder: (context, state) {
          return BlocProvider<ChangePasswordBloc>(
            create: (context) => ChangePasswordBloc(
              repositoryAuthentication: context
                  .read<IRepositoryAuthentication>(),
            ),
            child: ScreenChangePassword(),
          );
        },
      ),

      GoRoute(
        path: screenChangePhone,
        builder: (context, state) {
          return BlocProvider<ChangePhoneBloc>(
            create: (context) => ChangePhoneBloc(
              repositoryAuthentication: context
                  .read<IRepositoryAuthentication>(),
            ),
            child: ScreenChangePhone(),
          );
        },
      ),

      GoRoute(
        path: screenOrderDetailsShop,
        builder: (context, state) {
          final orderId = state.extra as String;
          return BlocProvider<OrderDetailsShopBloc>(
            create: (context) => OrderDetailsShopBloc(
              repositoryOrder: context.read<IRepositoryOrder>(),
            )..add(OrderDetailsShopEventFetch(orderId: orderId)),
            child: ScreenOrderDetailsShop(),
          );
        },
      ),

      GoRoute(
        path: screenProfileUpdateShop,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final ownerFirstName = extra[AppConstant.ownerFirstName] as String;
          final ownerLastName = extra[AppConstant.ownerLastName] as String;
          final shopAddress = extra[AppConstant.shopAddress] as String;
          final shopName = extra[AppConstant.shopName] as String;
          final openTime = extra[AppConstant.openTime] as String;
          final closeTime = extra[AppConstant.closeTime] as String;
          final weekends = extra[AppConstant.weekends] as String;
          final deliveryCharge = extra[AppConstant.deliveryCharge] as double;
          return BlocProvider<ProfileUpdateShopBloc>(
            create: (context) => ProfileUpdateShopBloc(
              repositoryProfile: context.read<IRepositoryProfile>(),
            ),
            child: ScreenProfileUpdateShop(
              ownerFirstName: ownerFirstName,
              ownerLastName: ownerLastName,
              shopAddress: shopAddress,
              shopName: shopName,
              openTime: openTime,
              closeTime: closeTime,
              weekends: weekends,
              deliveryCharge: deliveryCharge,
            ),
          );
        },
      ),

      GoRoute(
        path: screenPriceList,
        builder: (context, state) {
          return BlocProvider<PriceListShopBloc>(
            create: (context) => PriceListShopBloc(
              repositoryShopInventory: context.read<IRepositoryShopInventory>(),
            )..add(PriceListShopEventFetch()),
            child: ScreenPriceList(),
          );
        },
      ),

      GoRoute(
        path: screenPriceUpdate,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final price = extra[AppConstant.price] as double;
          final discountPrice = extra[AppConstant.discountPrice] as double;
          final ironPressPrice = extra[AppConstant.ironPressPrice] as double;
          final priceId = extra[AppConstant.priceId] as String;
          return BlocProvider<PriceUpdateBloc>(
            create: (context) => PriceUpdateBloc(
              repositoryInventory: context.read<IRepositoryShopInventory>(),
            ),
            child: ScreenPriceUpdate(
              price: price,
              discountPrice: discountPrice,
              ironPressPrice: ironPressPrice,
              priceId: priceId,
            ),
          );
        },
      ),

      GoRoute(
        path: screenPriceAdd,
        builder: (context, state) {
          return ScreenPriceAdd();
        },
      ),

      GoRoute(
        path: screenServiceList,
        builder: (context, state) {
          return BlocProvider<ServiceListBloc>(
            create: (context) => ServiceListBloc(
              repositoryShopInventory: context.read<IRepositoryShopInventory>(),
            )..add(ServiceListEventFetch()),
            child: ScreenServiceList(),
          );
        },
      ),

      GoRoute(
        path: screenServiceUpdate,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final serviceName = extra[AppConstant.serviceName] as String;
          final description = extra[AppConstant.description] as String;
          final serviceId = extra[AppConstant.serviceId] as String;
          return BlocProvider<ServiceUpdateBloc>(
            create: (context) => ServiceUpdateBloc(
              repositoryInventory: context.read<IRepositoryShopInventory>(),
            ),
            child: ScreenServiceUpdate(
              serviceName: serviceName,
              description: description,
              serviceId: serviceId,
            ),
          );
        },
      ),
    ],
  );
}
