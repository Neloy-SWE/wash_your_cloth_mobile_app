/* 
Created by Neloy on 11 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/bloc_global/global_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_button.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_constant.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';

import '../../../router/app_router.dart';

class ScreenRole extends StatelessWidget {
  const ScreenRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.selectRole)),
      body: SafeArea(
        child: Padding(
          padding: AppSize.paddingAll25,
          child: Center(
            child: BlocBuilder<GlobalBloc, GlobalState>(
              builder: (context, state) {
                final selectedRole = state.role;
                // print("selectedRole::: $selectedRole");

                return Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  children: [
                    if (selectedRole != null) ...[
                      Text(
                        "${AppText.selectedRoleColon} ${selectedRole.name.toUpperCase()}",
                        style: AppText.style.titleMedium,
                      ),
                      AppSize.gapH150,
                    ],

                    CustomButton(
                      onPressed: () {
                        context.read<GlobalBloc>().add(
                          GlobalEventSetRole(role: Role.user),
                        );
                      },
                      buttonText: AppText.userCapital,
                      textColor: selectedRole == Role.user
                          ? Colors.white
                          : AppColor.colorPrimary,
                      colorButton: selectedRole == Role.user
                          ? AppColor.colorPrimary
                          : Colors.white,
                      colorBorder: AppColor.colorPrimary,
                    ),
                    AppSize.gapH15,
                    CustomButton(
                      onPressed: () {
                        context.read<GlobalBloc>().add(
                          GlobalEventSetRole(role: Role.shop),
                        );
                      },
                      buttonText: AppText.shopCapital,
                      textColor: selectedRole == Role.shop
                          ? Colors.white
                          : AppColor.colorPrimary,
                      colorButton: selectedRole == Role.shop
                          ? AppColor.colorPrimary
                          : Colors.white,
                      colorBorder: AppColor.colorPrimary,
                    ),
                    AppSize.gapH80,

                    if (selectedRole != null) ...[
                      CustomButton(
                        onPressed: () {
                          context.push(AppRouter.screenLogin);
                        },
                        buttonText: AppText.proceed,
                        textColor: Colors.white,
                        colorButton: AppColor.colorPrimary,
                        colorBorder: AppColor.colorPrimary,
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
