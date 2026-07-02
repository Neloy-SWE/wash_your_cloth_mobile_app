/*
Created by Neloy on 18 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/client/client.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/api_login.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/api_refresh_token.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_authentication.dart';
import 'package:wash_your_cloth_mobile_app/presentation/bloc_global/global_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/bloc/authentication_bloc.dart';
import 'package:wash_your_cloth_mobile_app/router/app_router.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_theme.dart';

import 'data/local/local_storage_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/client/client.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/api_refresh_token.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_authentication.dart';
import 'package:wash_your_cloth_mobile_app/presentation/bloc_global/global_bloc.dart';
import 'package:wash_your_cloth_mobile_app/router/app_router.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_theme.dart';
import 'data/local/local_storage_service.dart';

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

          RepositoryProvider<Client>(create: (context) => Client()),

          RepositoryProvider<IApiRefreshToken>(
            create: (context) =>
                ApiRefreshToken(client: RepositoryProvider.of<Client>(context)),
          ),

          RepositoryProvider<IApiLogin>(
            create: (context) =>
                ApiLogin(client: RepositoryProvider.of<Client>(context)),
          ),

          RepositoryProvider<IRepositoryAuthentication>(
            create: (context) => RepositoryAuthentication(
              localStorageService: RepositoryProvider.of<LocalStorageService>(
                context,
              ),
              apiRefreshToken: RepositoryProvider.of<IApiRefreshToken>(context),
              apiLogin: RepositoryProvider.of<IApiLogin>(context),
            ),
          ),

          // RepositoryProvider<AppRouter>(create: (context) => AppRouter()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<GlobalBloc>(
              create: (context) => GlobalBloc(
                repositoryAuthentication:
                    RepositoryProvider.of<IRepositoryAuthentication>(context),
              )..add(GlobalEventGetLoginStatus()),
            ),

            BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                repositoryAuthentication:
                    RepositoryProvider.of<IRepositoryAuthentication>(context),
              ),
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
