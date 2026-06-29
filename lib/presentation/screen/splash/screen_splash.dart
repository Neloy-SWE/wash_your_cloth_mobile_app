/* 
Created by Neloy on 20 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/bloc_global/global_bloc.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_asset.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';

import '../../../router/app_router.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash>
    with TickerProviderStateMixin {
  late AnimationController controllerLoader;

  @override
  void initState() {
    controllerLoader =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addListener(() {
            setState(() {});
          });
    controllerLoader.repeat(reverse: false);

    // Timer(const Duration(seconds: 2), () {
    //   context.go(AppRouter.screenRole);
    // });

    super.initState();
  }

  @override
  void dispose() {
    controllerLoader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalBloc, GlobalState>(
      listenWhen: (previous, current) => previous.isLogin != current.isLogin,
      listener: (context, state) {
        if (state.isLogin == true) {
          context.go(AppRouter.screenDashboard);
        } else if (state.isLogin == false) {
          context.go(AppRouter.screenRole);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAsset.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppText.welcome),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.dry_cleaning_outlined,
                        size: 100,
                        color: Colors.white,
                      ),
                      AppSize.gapH20,
                      Text(
                        AppText.appTitle,
                        style: AppText.style.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      AppSize.gapH15,
                    ],
                  ),
                  // CircularProgressIndicator(color: Colors.white),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      color: Colors.white,
                      value: controllerLoader.value,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
