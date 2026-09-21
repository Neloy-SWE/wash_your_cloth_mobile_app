/*
Created by Neloy on 18 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/client/client.dart';
import 'data/local/local_storage_service.dart';
import 'data/network/api_call/authentication/api_change_password.dart';
import 'data/network/api_call/authentication/api_login.dart';
import 'data/network/api_call/authentication/api_otp_verify.dart';
import 'data/network/api_call/authentication/api_refresh_token.dart';
import 'data/network/api_call/authentication/api_registration.dart';
import 'data/network/api_call/order/shop/api_get_order_details_shop.dart';
import 'data/network/api_call/order/user/api_get_order_details_user.dart';
import 'data/network/api_call/order/api_get_order_list.dart';
import 'data/network/api_call/order/user/api_place_order.dart';
import 'data/network/api_call/profile/user/api_profile_update_user.dart';
import 'data/network/api_call/profile/user/api_profile_view_user.dart';
import 'data/network/api_call/resource/user/api_get_price_list_user.dart';
import 'data/network/api_call/shop/api_get_shop_list.dart';
import 'data/network/api_call/shop/user/api_get_shop_details_user.dart';
import 'data/repository/repository_authentication.dart';
import 'data/repository/repository_order.dart';
import 'data/repository/repository_profile.dart';
import 'data/repository/repository_shop.dart';
import 'presentation/bloc_global/global_bloc.dart';
import 'presentation/screen/shop/order/order_list/bloc/order_list_shop_bloc.dart';
import 'presentation/screen/user/order/order_list/bloc/order_list_user_bloc.dart';
import 'router/app_router.dart';
import 'utilities/app_text.dart';
import 'utilities/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<LocalStorageService>(
            create: (context) => LocalStorageService(),
          ),

          RepositoryProvider<Client>(
            create: (context) => Client(
              localStorageService: context.read<LocalStorageService>(),
            ),
          ),

          RepositoryProvider<IApiRefreshToken>(
            create: (context) =>
                ApiRefreshToken(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiLogin>(
            create: (context) => ApiLogin(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiRegistration>(
            create: (context) =>
                ApiRegistration(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiOTPVerify>(
            create: (context) => ApiOTPVerify(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetOrderList>(
            create: (context) =>
                ApiGetOrderList(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetOrderDetailsUser>(
            create: (context) =>
                ApiGetOrderDetailsUser(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetOrderDetailsShop>(
            create: (context) =>
                ApiGetOrderDetailsShop(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetShopList>(
            create: (context) => ApiGetShopList(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetShopDetailsUser>(
            create: (context) =>
                ApiGetShopDetailsUser(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetPriceListUser>(
            create: (context) =>
                ApiGetPriceListUser(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiPlaceOrder>(
            create: (context) => ApiPlaceOrder(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiProfileViewUser>(
            create: (context) =>
                ApiProfileViewUser(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiProfileUpdateUser>(
            create: (context) =>
                ApiProfileUpdateUser(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiChangePassword>(
            create: (context) =>
                ApiChangePassword(client: context.read<Client>()),
          ),

          RepositoryProvider<IRepositoryAuthentication>(
            create: (context) => RepositoryAuthentication(
              localStorageService: context.read<LocalStorageService>(),
              apiRefreshToken: context.read<IApiRefreshToken>(),
              apiLogin: context.read<IApiLogin>(),
              apiRegistration: context.read<IApiRegistration>(),
              apiOTPVerify: context.read<IApiOTPVerify>(),
              apiChangePassword: context.read<IApiChangePassword>(),
            ),
          ),

          RepositoryProvider<IRepositoryOrder>(
            create: (context) => RepositoryOrder(
              apiGetOrderList: context.read<IApiGetOrderList>(),
              apiGetOrderDetailsUser: context.read<IApiGetOrderDetailsUser>(),
              apiPlaceOrder: context.read<IApiPlaceOrder>(),
              apiGetOrderDetailsShop: context.read<IApiGetOrderDetailsShop>(),
            ),
          ),

          RepositoryProvider<IRepositoryShop>(
            create: (context) => RepositoryShop(
              apiGetShopList: context.read<IApiGetShopList>(),
              apiGetShopDetailsUser: context.read<IApiGetShopDetailsUser>(),
              apiGetPriceListUser: context.read<IApiGetPriceListUser>(),
            ),
          ),

          RepositoryProvider<IRepositoryProfile>(
            create: (context) => RepositoryProfile(
              apiProfileViewUser: context.read<IApiProfileViewUser>(),
              apiProfileUpdateUser: context.read<IApiProfileUpdateUser>(),
            ),
          ),

          // RepositoryProvider<AppRouter>(create: (context) => AppRouter()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<GlobalBloc>(
              create: (context) => GlobalBloc(
                repositoryAuthentication: context
                    .read<IRepositoryAuthentication>(),
              )..add(GlobalEventGetLoginStatus()),
            ),

            BlocProvider<OrderListUserBloc>(
              create: (context) => OrderListUserBloc(
                repositoryOrder: context.read<IRepositoryOrder>(),
              )..add(OrderListUserEventFetch()),
            ),
            BlocProvider<OrderListShopBloc>(
              create: (context) => OrderListShopBloc(
                repositoryOrder: context.read<IRepositoryOrder>(),
              )..add(OrderListShopEventFetch()),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.door,
            theme: AppTheme.get,
            title: AppText.appTitle,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.noScaling),
                child: child!,
              );
            },
          ),
        ),
      ),
    );
  }
}
