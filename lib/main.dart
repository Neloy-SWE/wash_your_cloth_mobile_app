/*
Created by Neloy on 18 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/client/client.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/authentication/api_login.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/authentication/api_refresh_token.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/authentication/api_registration.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_authentication.dart';
import 'package:wash_your_cloth_mobile_app/presentation/bloc_global/global_bloc.dart';
import 'package:wash_your_cloth_mobile_app/router/app_router.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_theme.dart';

import 'data/local/local_storage_service.dart';
import 'data/network/api_call/authentication/api_otp_verify.dart';
import 'data/network/api_call/order/api_get_order_details_user.dart';
import 'data/network/api_call/order/i_api_get_order_list.dart';
import 'data/repository/repository_order.dart';

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

          RepositoryProvider<IRepositoryAuthentication>(
            create: (context) => RepositoryAuthentication(
              localStorageService: context.read<LocalStorageService>(),
              apiRefreshToken: context.read<IApiRefreshToken>(),
              apiLogin: context.read<IApiLogin>(),
              apiRegistration: context.read<IApiRegistration>(),
              apiOTPVerify: context.read<IApiOTPVerify>(),
            ),
          ),

          RepositoryProvider<IApiGetOrderList>(
            create: (context) =>
                ApiGetOrderListUser(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetOrderDetailsUser>(
            create: (context) =>
                ApiGetOrderDetailsUser(client: context.read<Client>()),
          ),

          RepositoryProvider<IRepositoryOrder>(
            create: (context) => RepositoryOrder(
              apiGetOrderList: context.read<IApiGetOrderList>(),
              apiGetOrderDetailsUser: context.read<IApiGetOrderDetailsUser>(),
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
