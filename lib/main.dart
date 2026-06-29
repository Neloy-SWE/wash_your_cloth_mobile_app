/*
Created by Neloy on 18 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

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
  final localStorageService = LocalStorageService();

  final client = Client();
  final apiRefreshToken = ApiRefreshToken(client: client);

  final repositoryAuthentication = RepositoryAuthentication(
    localStorageService: localStorageService,
    apiRefreshToken: apiRefreshToken,
  );

  final globalBloc = GlobalBloc(
    repositoryAuthentication: repositoryAuthentication,
  )..add(GlobalEventGetLoginStatus());

  final appRouter = AppRouter();

  runApp(
    MyApp(
      localStorageService: localStorageService,
      client: client,
      apiRefreshToken: apiRefreshToken,
      repositoryAuthentication: repositoryAuthentication,
      globalBloc: globalBloc,
      appRouter: appRouter,
    ),
  );
}

class MyApp extends StatelessWidget {
  final LocalStorageService localStorageService;
  final Client client;
  final IApiRefreshToken apiRefreshToken;
  final IRepositoryAuthentication repositoryAuthentication;
  final GlobalBloc globalBloc;
  final AppRouter appRouter;

  const MyApp({
    super.key,
    required this.localStorageService,
    required this.client,
    required this.apiRefreshToken,
    required this.repositoryAuthentication,
    required this.globalBloc,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<LocalStorageService>.value(
            value: localStorageService,
          ),
          RepositoryProvider<Client>.value(value: client),
          RepositoryProvider<IApiRefreshToken>.value(value: apiRefreshToken),
          RepositoryProvider<IRepositoryAuthentication>.value(
            value: repositoryAuthentication,
          ),
        ],
        child: BlocProvider<GlobalBloc>.value(
          value: globalBloc,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter.door,
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
