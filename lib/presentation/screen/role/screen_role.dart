/* 
Created by Neloy on 11 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/bloc_global/global_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_button.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_snack_bar.dart';
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
                    Text(
                      selectedRole != null
                          ? "${AppText.selectedRoleColon} ${selectedRole.name.toUpperCase()}"
                          : "",
                      style: AppText.style.titleMedium,
                    ),
                    AppSize.gapH150,

                    Row(
                      children: [
                        Expanded(
                          child: _buildRoleCard(
                            context: context,
                            title: AppText.userCapital,
                            icon: Icons.person_outline_rounded,
                            isSelected: selectedRole == Role.user,
                            onTap: () {
                              context.read<GlobalBloc>().add(
                                GlobalEventSetRole(role: Role.user),
                              );
                            },
                          ),
                        ),

                        AppSize.gapW15,

                        Expanded(
                          child: _buildRoleCard(
                            context: context,
                            title: AppText.shopCapital,
                            icon: Icons.storefront_rounded,
                            isSelected: selectedRole == Role.shop,
                            onTap: () {
                              context.read<GlobalBloc>().add(
                                GlobalEventSetRole(role: Role.shop),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    AppSize.gapH80,

                    CustomButton(
                      onPressed: () {
                        if (selectedRole != null) {
                          context.push(AppRouter.screenLogin);
                        } else {
                          CustomSnackBar.primary(
                            context: context,
                            contentText: AppText.pleaseSelectARole,
                          );
                        }
                      },
                      buttonText: AppText.proceed,
                      textColor: selectedRole != null
                          ? Colors.white
                          : AppColor.colorPrimary,
                      colorButton: selectedRole != null
                          ? AppColor.colorPrimary
                          : Colors.white,
                      colorBorder: AppColor.colorPrimary,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final cardColor = isSelected ? AppColor.colorPrimary : Colors.white;
    final contentColor = isSelected ? Colors.white : AppColor.colorPrimary;

    return AspectRatio(
      aspectRatio: 1.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: AppSize.borderRadiusAll10,
          border: Border.all(
            color: AppColor.colorPrimary,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: AppSize.borderRadiusAll10,
          child: Padding(
            padding: AppSize.paddingAll10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48, color: contentColor),
                AppSize.gapH10,

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppText.style.titleMedium?.copyWith(
                    color: contentColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
