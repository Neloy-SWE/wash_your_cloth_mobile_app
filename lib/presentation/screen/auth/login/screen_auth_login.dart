/* 
Created by Neloy on 10 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';

import '../../../../router/app_router.dart';
import '../../../../utilities/app_color.dart';
import '../../../../utilities/app_validator.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_textfield.dart';
import '../../../custom_widget/custom_titled_divider.dart';

class ScreenAuthLogin extends StatefulWidget {
  const ScreenAuthLogin({super.key});

  @override
  State<ScreenAuthLogin> createState() => _ScreenAuthLoginState();
}

class _ScreenAuthLoginState extends State<ScreenAuthLogin> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();
  bool isPasswordSecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.login)),
      body: SafeArea(
        child: ListView(
          padding: AppSize.paddingAll25,
          children: [
            Form(
              key: _loginKey,
              child: Column(
                children: [
                  AppSize.gapH150,
                  // phone:
                  CustomFieldPrimary(
                    controller: phoneController,
                    textInputType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    title: AppText.phone,
                    label: AppText.phoneHint,
                    validator: (value) {
                      if (AppValidator.isPhone(value)) {
                        return null;
                      } else {
                        return AppValidator.validatePhone;
                      }
                    },
                  ),
                  AppSize.gapH15,

                  // password:
                  CustomFieldPrimary(
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    title: AppText.password,
                    label: AppText.passwordHint,
                    isSecure: isPasswordSecure,
                    suffixWidget: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordSecure = !isPasswordSecure;
                        });
                      },
                      icon: Icon(
                        isPasswordSecure
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    validator: (value) {
                      // todo: need some solid conditions
                      if (value == null || value.isEmpty) {
                        return AppValidator.validatorPassword;
                      } else {
                        return null;
                      }
                    },
                  ),
                  AppSize.gapH35,

                  // login button:
                  CustomButton(
                      onPressed: _login,
                      buttonText: AppText.login,
                  ),

                  CustomTitledDivider(title: AppText.orNew),

                  // navigate registration:
                  CustomButton(
                    onPressed: () {
                      context.pushReplacement(AppRouter.screenAuthRegistration);
                    },
                    buttonText: AppText.registration,
                    textColor: AppColor.colorPrimary,
                    colorButton: Colors.white,
                  ),
                  AppSize.gapH35,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    if (_loginKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      context.go(AppRouter.screenDashboard);
    }
  }
}
