/* 
Created by Neloy on 18 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/change_phone/bloc/change_phone_bloc.dart';

import '../../../../router/app_router.dart';
import '../../../../utilities/app_constant.dart';
import '../../../../utilities/app_size.dart';
import '../../../../utilities/app_text.dart';
import '../../../../utilities/app_validator.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_dialogue.dart';
import '../../../custom_widget/custom_snack_bar.dart';
import '../../../custom_widget/custom_text_field.dart';

class ScreenChangePhone extends StatefulWidget {
  const ScreenChangePhone({super.key});

  @override
  State<ScreenChangePhone> createState() => _ScreenChangePhoneState();
}

class _ScreenChangePhoneState extends State<ScreenChangePhone> {
  final TextEditingController controllerOldPhone = TextEditingController();
  final TextEditingController controllerNewPhone = TextEditingController();

  final _updatePhoneKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controllerOldPhone.dispose();
    controllerNewPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.updatePhone)),
      body: SafeArea(
        child: BlocConsumer<ChangePhoneBloc, ChangePhoneState>(
          listener: (context, state) {
            if (state is ChangePhoneStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is ChangePhoneStateNavigateOTP) {
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
            } else if (state is ChangePhoneStateResult) {
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
                key: _updatePhoneKey,
                child: Column(
                  children: [
                    // old phone:
                    CustomFieldPrimary(
                      controller: controllerOldPhone,
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      title: AppText.oldPhone,
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

                    // new phone:
                    CustomFieldPrimary(
                      controller: controllerNewPhone,
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      title: AppText.newPhone,
                      label: AppText.phoneHint,
                      validator: (value) {
                        if (value == controllerOldPhone.text){
                          return AppValidator.validatorIsPhoneMatched;
                        }
                        if (AppValidator.isPhone(value)) {
                          return null;
                        } else {
                          return AppValidator.validatePhone;
                        }
                      },
                    ),
                    AppSize.gapH35,
                    CustomButton(
                      onPressed: _updatePhone,
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

  void _updatePhone() {
    if (_updatePhoneKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      context.read<ChangePhoneBloc>().add(
        ChangePhoneEventProceed(
          oldPhone: controllerOldPhone.text.trim(),
          newPhone: controllerNewPhone.text.trim(),
        ),
      );
    }
  }
}
