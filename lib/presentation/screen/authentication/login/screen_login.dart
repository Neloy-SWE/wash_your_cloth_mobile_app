/* 
Created by Neloy on 10 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/bloc_global/global_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_dialogue.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_snack_bar.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/login/bloc/login_bloc.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';

import '../../../../router/app_router.dart';
import '../../../../utilities/app_color.dart';
import '../../../../utilities/app_constant.dart';
import '../../../../utilities/app_validator.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_textfield.dart';
import '../../../custom_widget/custom_titled_divider.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  final _loginKey = GlobalKey<FormState>();
  bool isPasswordSecure = true;

  @override
  void dispose() {
    controllerPhone.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selectedRole = context.read<GlobalBloc>().state.role;
    return Scaffold(
      appBar: AppBar(title: Text(AppText.login)),
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is LoginStateNavigateLogin) {
              CallDialogue.hideLoader(context);
              if (selectedRole == Role.user){
                context.go(AppRouter.screenHomeUser);
              } else {
                context.go(AppRouter.screenHomeShop);
              }
            } else if (state is LoginStateNavigateOTP) {
              CallDialogue.hideLoader(context);
              context.read<GlobalBloc>().add(
                GlobalEventSetOTPInfo(
                  otpRequestId: state.otpRequestId,
                  recordId: state.recordId,
                ),
              );
              CustomSnackBar.primary(
                context: context,
                contentText: state.message,
              );
              context.push(AppRouter.screenOTP);
            } else if (state is LoginStateResult) {
              CallDialogue.hideLoader(context);
              CallDialogue.showResult(
                context: context,
                message: state.message,
                onOk: () {
                  CallDialogue.hideLoader(context);
                },
              );
            }
          },
          builder: (context, state) {
            return ListView(
              padding: AppSize.paddingAll25,
              children: [
                Form(
                  key: _loginKey,
                  child: Column(
                    children: [
                      AppSize.gapH150,
                      // phone:
                      CustomFieldPrimary(
                        controller: controllerPhone,
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
                        controller: controllerPassword,
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
                          context.pushReplacement(AppRouter.screenRegistration);
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
            );
          },
        ),
      ),
    );
  }

  void _login() {
    if (_loginKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();

      String role = context.read<GlobalBloc>().state.role!.name;

      context.read<LoginBloc>().add(
        LoginEventLogin(
          phone: controllerPhone.text,
          password: controllerPassword.text,
          role: role,
        ),
      );
    }
  }
}
