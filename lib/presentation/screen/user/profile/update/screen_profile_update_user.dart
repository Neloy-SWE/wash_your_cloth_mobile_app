/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';

import '../../../../../router/app_router.dart';
import '../../../../../utilities/app_size.dart';
import '../../../../../utilities/app_text.dart';
import '../../../../../utilities/app_tool.dart';
import '../../../../../utilities/app_validator.dart';
import '../../../../custom_widget/custom_button.dart';
import '../../../../custom_widget/custom_dialogue.dart';
import '../../../../custom_widget/custom_snack_bar.dart';
import '../../../../custom_widget/custom_textfield.dart';
import 'bloc/profile_update_user_bloc.dart';

class ScreenProfileUpdateUser extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String address;

  const ScreenProfileUpdateUser({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.address,
  });

  @override
  State<ScreenProfileUpdateUser> createState() =>
      _ScreenProfileUpdateUserState();
}

class _ScreenProfileUpdateUserState extends State<ScreenProfileUpdateUser> {
  final _profileBuyerEditKey = GlobalKey<FormState>();
  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();

  final ValueNotifier<bool> isFormChanged = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    controllerFirstName.text = widget.firstName;
    controllerLastName.text = widget.lastName;
    controllerAddress.text = widget.address;

    controllerFirstName.addListener(_checkIsChanged);
    controllerLastName.addListener(_checkIsChanged);
    controllerAddress.addListener(_checkIsChanged);
  }

  void _checkIsChanged() {
    final hasChanged =
        controllerFirstName.text.trim() != widget.firstName.trim() ||
        controllerLastName.text.trim() != widget.lastName.trim() ||
        controllerAddress.text.trim() != widget.address.trim();

    if (isFormChanged.value != hasChanged) {
      isFormChanged.value = hasChanged;
    }
  }

  @override
  void dispose() {
    controllerFirstName.removeListener(_checkIsChanged);
    controllerLastName.removeListener(_checkIsChanged);
    controllerAddress.removeListener(_checkIsChanged);
    controllerFirstName.dispose();
    controllerLastName.dispose();
    controllerAddress.dispose();
    isFormChanged.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.updateProfile)),
      body: SafeArea(
        child: BlocConsumer<ProfileUpdateUserBloc, ProfileUpdateUserState>(
          listener: (context, state) {
            if (state is ProfileUpdateUserStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is ProfileUpdateUserStateResult) {
              CallDialogue.hideLoader(context);
              if (state.isNavigate) {
                CustomSnackBar.primary(
                  context: context,
                  contentText: state.message,
                );
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted && context.canPop()) {
                    context.pop(true);
                  }
                });
              } else {
                CallDialogue.showResult(
                  context: context,
                  message: state.message,
                  onOk: () => CallDialogue.hideLoader(context),
                );
              }
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: AppSize.paddingAll25,
              child: Form(
                key: _profileBuyerEditKey,
                child: Column(
                  children: [
                    CustomFieldPrimary(
                      controller: controllerFirstName,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      title: AppText.firstName,
                      label: AppText.firstNameHint,
                      inputFormatters: [AppToolSpaceFormatter()],
                      validator: (value) {
                        if (AppValidator.isName(value)) {
                          return null;
                        } else {
                          return AppValidator.validatorName;
                        }
                      },
                    ),
                    AppSize.gapH15,
                    CustomFieldPrimary(
                      controller: controllerLastName,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      title: AppText.lastName,
                      label: AppText.lastNameHint,
                      inputFormatters: [AppToolSpaceFormatter()],
                      validator: (value) {
                        if (AppValidator.isName(value)) {
                          return null;
                        } else {
                          return AppValidator.validatorName;
                        }
                      },
                    ),
                    AppSize.gapH15,
                    CustomFieldPrimary(
                      controller: controllerAddress,
                      textInputType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.done,
                      title: AppText.address,
                      label: AppText.addressHint,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppValidator.validatorAddress;
                        }
                        return null;
                      },
                    ),
                    AppSize.gapH80,

                    ValueListenableBuilder<bool>(
                      valueListenable: isFormChanged,
                      builder: (context, isChanged, child) {
                        return CustomButton(
                          onPressed: () {
                            if (isChanged) {
                              if (_profileBuyerEditKey.currentState!
                                  .validate()) {
                                context.read<ProfileUpdateUserBloc>().add(
                                  ProfileUpdateUserEventSubmit(
                                    firstName: controllerFirstName.text.trim(),
                                    lastName: controllerLastName.text.trim(),
                                    address: controllerAddress.text.trim(),
                                  ),
                                );
                              }
                            } else {
                              CustomSnackBar.primary(
                                context: context,
                                contentText:
                                    AppValidator.validatorProfileUpdate,
                                backgroundColor: AppColor.colorDanger,
                              );
                            }
                          },
                          buttonText: AppText.update,
                          colorButton: isChanged
                              ? AppColor.colorPrimary
                              : AppColor.colorBorderStatusPending,
                          colorBorder: isChanged
                              ? AppColor.colorPrimary
                              : AppColor.colorBorderStatusPending,
                        );
                      },
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
}
