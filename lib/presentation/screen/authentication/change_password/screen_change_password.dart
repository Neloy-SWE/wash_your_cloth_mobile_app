/* 
Created by Neloy on 13 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/change_password/bloc/change_password_bloc.dart';

import '../../../../router/app_router.dart';
import '../../../../utilities/app_constant.dart';
import '../../../../utilities/app_size.dart';
import '../../../../utilities/app_text.dart';
import '../../../../utilities/app_validator.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_dialogue.dart';
import '../../../custom_widget/custom_snack_bar.dart';
import '../../../custom_widget/custom_text_field.dart';

class ScreenChangePassword extends StatefulWidget {
  const ScreenChangePassword({super.key});

  @override
  State<ScreenChangePassword> createState() => _ScreenChangePasswordState();
}

class _ScreenChangePasswordState extends State<ScreenChangePassword> {
  final TextEditingController controllerOldPassword = TextEditingController();
  final TextEditingController controllerNewPassword = TextEditingController();
  final TextEditingController controllerConfirmNewPassword =
      TextEditingController();

  bool isOldPasswordSecure = true;
  bool isNewPasswordSecure = true;
  bool isConfirmNewPasswordSecure = true;

  final _updatePasswordKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controllerOldPassword.dispose();
    controllerNewPassword.dispose();
    controllerConfirmNewPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.updatePassword)),
      body: SafeArea(
        child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is ChangePasswordStateNavigateOTP) {
              CallDialogue.hideLoader(context);
              CustomSnackBar.primary(
                context: context,
                contentText: state.message,
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.push(
                    AppRouter.screenOTP,
                    extra: {
                      AppConstant.otpRequestId: state.otpRequestId,
                      AppConstant.recordId: state.recordId,
                    },
                  );
                }
              });
            } else if (state is ChangePasswordStateResult) {
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
            return SingleChildScrollView(
              padding: AppSize.paddingAll25,
              child: Form(
                key: _updatePasswordKey,
                child: Column(
                  children: [
                    // old password:
                    CustomFieldPrimary(
                      controller: controllerOldPassword,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      title: AppText.oldPassword,
                      label: AppText.passwordHint,
                      isSecure: isOldPasswordSecure,
                      suffixWidget: IconButton(
                        onPressed: () {
                          setState(() {
                            isOldPasswordSecure = !isOldPasswordSecure;
                          });
                        },
                        icon: Icon(
                          isOldPasswordSecure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppValidator.validatorPassword;
                        } else {
                          return null;
                        }
                      },
                    ),
                    AppSize.gapH15,

                    // new password:
                    CustomFieldPrimary(
                      controller: controllerNewPassword,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      title: AppText.newPassword,
                      label: AppText.passwordHint,
                      isSecure: isNewPasswordSecure,
                      suffixWidget: IconButton(
                        onPressed: () {
                          setState(() {
                            isNewPasswordSecure = !isNewPasswordSecure;
                          });
                        },
                        icon: Icon(
                          isNewPasswordSecure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppValidator.validatorPassword;
                        } else if (value == controllerOldPassword.text) {
                          return AppValidator.validatorIsMatched;
                        } else {
                          return null;
                        }
                      },
                    ),
                    AppSize.gapH15,

                    // confirm new password:
                    CustomFieldPrimary(
                      controller: controllerConfirmNewPassword,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      title: AppText.confirmNewPassword,
                      label: AppText.passwordHint,
                      isSecure: isConfirmNewPasswordSecure,
                      suffixWidget: IconButton(
                        onPressed: () {
                          setState(() {
                            isConfirmNewPasswordSecure =
                                !isConfirmNewPasswordSecure;
                          });
                        },
                        icon: Icon(
                          isConfirmNewPasswordSecure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppValidator.validatorPassword;
                        } else if (value != controllerNewPassword.text) {
                          return AppValidator.validatorPasswordIsNotMatched;
                        } else {
                          return null;
                        }
                      },
                    ),
                    AppSize.gapH35,
                    CustomButton(
                      onPressed: _updatePassword,
                      buttonText: AppText.update,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _updatePassword() {
    if (_updatePasswordKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      context.read<ChangePasswordBloc>().add(
        ChangePasswordEventProceed(
          oldPassword: controllerOldPassword.text.trim(),
          newPassword: controllerNewPassword.text.trim(),
          confirmPassword: controllerConfirmNewPassword.text.trim(),
        ),
      );
    }
  }
}
