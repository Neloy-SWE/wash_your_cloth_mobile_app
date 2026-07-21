/* 
Created by Neloy on 09 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_textfield.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_title.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/registration/bloc/registration_bloc.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_constant.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_validator.dart';

import '../../../../router/app_router.dart';
import '../../../bloc_global/global_bloc.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_dialogue.dart';
import '../../../custom_widget/custom_snack_bar.dart';
import '../../../custom_widget/custom_weekend_selector.dart';

class ScreenRegistration extends StatefulWidget {
  const ScreenRegistration({super.key});

  @override
  State<ScreenRegistration> createState() => _ScreenRegistrationState();
}

class _ScreenRegistrationState extends State<ScreenRegistration> {
  final _registrationKey = GlobalKey<FormState>();

  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  final TextEditingController controllerShopName = TextEditingController();
  final TextEditingController controllerOpenTime = TextEditingController();
  final TextEditingController controllerCloseTime = TextEditingController();

  bool isPasswordSecure = true;

  String selectedWeekends = "";

  @override
  void dispose() {
    controllerFirstName.dispose();
    controllerLastName.dispose();
    controllerAddress.dispose();
    controllerPhone.dispose();
    controllerPassword.dispose();
    controllerShopName.dispose();
    controllerOpenTime.dispose();
    controllerCloseTime.dispose();
    super.dispose();
  }

  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var selectedRole = context.read<GlobalBloc>().state.role;
    return Scaffold(
      appBar: AppBar(title: Text(AppText.registration)),
      body: SafeArea(
        child: BlocConsumer<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is RegistrationStateNavigateOTP) {
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
            } else if (state is RegistrationStateResult) {
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
            return Padding(
              padding: AppSize.paddingAll25,
              child: Form(
                key: _registrationKey,
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: .stretch,
                          children: [
                            CustomFieldPrimary(
                              controller: controllerFirstName,
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              title: selectedRole == Role.shop
                                  ? AppText.ownerFirstName
                                  : AppText.firstName,
                              label: AppText.firstNameHint,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppValidator.validatorName;
                                }
                                return null;
                              },
                            ),
                            AppSize.gapH15,

                            CustomFieldPrimary(
                              controller: controllerLastName,
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              title: selectedRole == Role.shop
                                  ? AppText.ownerLastName
                                  : AppText.lastName,
                              label: AppText.lastNameHint,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppValidator.validatorName;
                                }
                                return null;
                              },
                            ),
                            AppSize.gapH15,

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

                            if (selectedRole == Role.shop) ...[
                              CustomFieldPrimary(
                                controller: controllerShopName,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                title: AppText.shopName,
                                label: AppText.shopNameHint,
                                validator: (value) {
                                  if (selectedRole == Role.shop) {
                                    if (value!.isEmpty) {
                                      return AppValidator.validatorShopName;
                                    }
                                    return null;
                                  }
                                  return null;
                                },
                              ),
                              AppSize.gapH15,

                              // Open Time Field
                              InkWell(
                                onTap: () =>
                                    _selectTime(context, controllerOpenTime),
                                child: IgnorePointer(
                                  child: CustomFieldPrimary(
                                    controller: controllerOpenTime,
                                    title: AppText.openTime,
                                    label: "09:00 AM",
                                    validator: (value) {
                                      if (selectedRole == Role.shop) {
                                        if (value!.isEmpty) {
                                          return AppValidator.validatorOpenTime;
                                        }
                                        return null;
                                      }
                                      return null;
                                    },
                                    textInputType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),
                              AppSize.gapH15,

                              // Close Time Field
                              InkWell(
                                onTap: () =>
                                    _selectTime(context, controllerCloseTime),
                                child: IgnorePointer(
                                  child: CustomFieldPrimary(
                                    controller: controllerCloseTime,
                                    title: AppText.closeTime,
                                    label: "10:30 PM",
                                    validator: (value) {
                                      if (selectedRole == Role.shop) {
                                        if (value!.isEmpty) {
                                          return AppValidator
                                              .validatorCloseTime;
                                        }
                                        return null;
                                      }
                                      return null;
                                    },
                                    textInputType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),
                              AppSize.gapH15,

                              // Weekend Selector Component
                              CustomTitlePrimary(title: AppText.weekends),
                              WeekendSelector(
                                initialSelectedDays: selectedWeekends,
                                onChanged: (csvDays) {
                                  selectedWeekends = csvDays;
                                },
                              ),
                              AppSize.gapH15,
                            ],

                            CustomFieldPrimary(
                              controller: controllerAddress,
                              textInputType: TextInputType.streetAddress,
                              textInputAction: TextInputAction.next,
                              title: AppText.address,
                              label: AppText.addressHint,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppValidator.validatorAddress;
                                }
                                return null;
                              },
                            ),
                            AppSize.gapH15,

                            CustomFieldPrimary(
                              controller: controllerPassword,
                              textInputType: TextInputType.visiblePassword,
                              textInputAction: selectedRole == Role.shop
                                  ? TextInputAction.next
                                  : TextInputAction.done,
                              isSecure: isPasswordSecure,
                              title: AppText.password,
                              label: AppText.passwordHint,
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
                              validator: (val) => val!.length < 6
                                  ? AppValidator.validatorPassword
                                  : null,
                            ),
                            AppSize.gapH15,
                          ],
                        ),
                      ),
                    ),
                    AppSize.gapH15,
                    CustomButton(
                      onPressed: () => _registration(selectedRole!),
                      buttonText: AppText.registration,
                    ),
                    AppSize.gapH35,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _registration(Role selectedRole) {
    if (_registrationKey.currentState!.validate()) {
      if (selectedRole == Role.shop && selectedWeekends.isEmpty) {
        CustomSnackBar.primary(
          context: context,
          contentText: AppValidator.validatorWeekends,
          backgroundColor: AppColor.colorDanger,
        );
        return;
      } else {
        FocusManager.instance.primaryFocus?.unfocus();
        context.read<RegistrationBloc>().add(
          RegistrationEventRegistration(
            role: selectedRole.name,
            firstName: controllerFirstName.text.trim(),
            lastName: controllerLastName.text.trim(),
            address: controllerAddress.text.trim(),
            phone: controllerPhone.text.trim(),
            password: controllerPassword.text,
            shopName: selectedRole == Role.shop
                ? controllerShopName.text.trim()
                : null,
            openTime: selectedRole == Role.shop
                ? controllerOpenTime.text
                : null,
            closeTime: selectedRole == Role.shop
                ? controllerCloseTime.text
                : null,
            weekends: selectedRole == Role.shop ? selectedWeekends : null,
          ),
        );
      }
    }
  }
}
