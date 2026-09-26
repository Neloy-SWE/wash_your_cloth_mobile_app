/* 
Created by Neloy on 26 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../utilities/app_color.dart';
import '../../../../../utilities/app_size.dart';
import '../../../../../utilities/app_text.dart';
import '../../../../../utilities/app_tool.dart';
import '../../../../../utilities/app_validator.dart';
import '../../../../custom_widget/custom_button.dart';
import '../../../../custom_widget/custom_dialogue.dart';
import '../../../../custom_widget/custom_snack_bar.dart';
import '../../../../custom_widget/custom_text_field.dart';
import '../../../../custom_widget/custom_title.dart';
import '../../../../custom_widget/custom_weekend_selector.dart';
import 'bloc/profile_update_shop_bloc.dart';

class ScreenProfileUpdateShop extends StatefulWidget {
  final String ownerFirstName;
  final String ownerLastName;
  final String shopAddress;

  // final String longitude;
  // final String latitude;

  final String shopName;
  final String openTime;
  final String closeTime;
  final String weekends;
  final double deliveryCharge;

  const ScreenProfileUpdateShop({
    super.key,
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.shopAddress,
    // required this.longitude,
    // required this.latitude,
    required this.shopName,
    required this.openTime,
    required this.closeTime,
    required this.weekends,
    required this.deliveryCharge,
  });

  @override
  State<ScreenProfileUpdateShop> createState() =>
      _ScreenProfileUpdateShopState();
}

class _ScreenProfileUpdateShopState extends State<ScreenProfileUpdateShop> {
  final _profileShopEditKey = GlobalKey<FormState>();

  final TextEditingController controllerOwnerFirstName =
      TextEditingController();
  final TextEditingController controllerOwnerLastName = TextEditingController();
  final TextEditingController controllerShopAddress = TextEditingController();
  final TextEditingController controllerShopName = TextEditingController();
  final TextEditingController controllerOpenTime = TextEditingController();
  final TextEditingController controllerCloseTime = TextEditingController();
  final TextEditingController controllerDeliveryCharge =
      TextEditingController();

  final ValueNotifier<bool> isFormChanged = ValueNotifier<bool>(false);

  // String selectedWeekends = "";
  late final ValueNotifier<String> selectedWeekends;

  @override
  void initState() {
    controllerOwnerFirstName.text = widget.ownerFirstName;
    controllerOwnerLastName.text = widget.ownerLastName;
    controllerShopAddress.text = widget.shopAddress;
    controllerShopName.text = widget.shopName;
    controllerOpenTime.text = widget.openTime;
    controllerCloseTime.text = widget.closeTime;
    selectedWeekends = ValueNotifier<String>(widget.weekends);
    controllerDeliveryCharge.text = widget.deliveryCharge.toString();

    controllerOwnerFirstName.addListener(_checkIsChanged);
    controllerOwnerLastName.addListener(_checkIsChanged);
    controllerShopAddress.addListener(_checkIsChanged);
    controllerShopName.addListener(_checkIsChanged);
    controllerOpenTime.addListener(_checkIsChanged);
    controllerCloseTime.addListener(_checkIsChanged);
    controllerDeliveryCharge.addListener(_checkIsChanged);
    selectedWeekends.addListener(_checkIsChanged);
    super.initState();
  }

  void _checkIsChanged() {
    final hasChanged =
        controllerOwnerFirstName.text.trim() != widget.ownerFirstName.trim() ||
        controllerOwnerLastName.text.trim() != widget.ownerLastName.trim() ||
        controllerShopAddress.text.trim() != widget.shopAddress.trim() ||
        controllerShopName.text.trim() != widget.shopName.trim() ||
        controllerOpenTime.text.trim() != widget.openTime.trim() ||
        controllerCloseTime.text.trim() != widget.closeTime.trim() ||
        controllerDeliveryCharge.text.trim() !=
            widget.deliveryCharge.toString() ||
        selectedWeekends.value != widget.weekends;

    if (isFormChanged.value != hasChanged) {
      isFormChanged.value = hasChanged;
    }
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
  void dispose() {
    controllerOwnerFirstName.removeListener(_checkIsChanged);
    controllerOwnerLastName.removeListener(_checkIsChanged);
    controllerShopAddress.removeListener(_checkIsChanged);
    controllerShopName.removeListener(_checkIsChanged);
    controllerOpenTime.removeListener(_checkIsChanged);
    controllerCloseTime.removeListener(_checkIsChanged);
    controllerDeliveryCharge.removeListener(_checkIsChanged);
    selectedWeekends.removeListener(_checkIsChanged);

    controllerOwnerFirstName.dispose();
    controllerOwnerLastName.dispose();
    controllerShopAddress.dispose();
    controllerShopName.dispose();
    controllerOpenTime.dispose();
    controllerCloseTime.dispose();
    controllerDeliveryCharge.dispose();
    selectedWeekends.dispose();
    isFormChanged.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.updateProfile)),
      body: SafeArea(
        child: BlocConsumer<ProfileUpdateShopBloc, ProfileUpdateShopState>(
          listener: (context, state) {
            if (state is ProfileUpdateShopStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is ProfileUpdateShopStateResult) {
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
                key: _profileShopEditKey,
                child: Column(
                  children: [
                    CustomFieldPrimary(
                      controller: controllerOwnerFirstName,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      title: AppText.ownerFirstName,
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
                      controller: controllerOwnerLastName,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      title: AppText.ownerLastName,
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
                      controller: controllerShopAddress,
                      textInputType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.done,
                      title: AppText.shopAddress,
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
                      controller: controllerShopName,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      title: AppText.shopName,
                      label: AppText.shopNameHint,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppValidator.validatorShopName;
                        }
                        return null;
                      },
                    ),
                    AppSize.gapH15,

                    InkWell(
                      onTap: () => _selectTime(context, controllerOpenTime),
                      child: IgnorePointer(
                        child: CustomFieldPrimary(
                          controller: controllerOpenTime,
                          title: AppText.openTime,
                          label: "09:00 AM",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppValidator.validatorOpenTime;
                            }
                            return null;
                          },
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    AppSize.gapH15,

                    InkWell(
                      onTap: () => _selectTime(context, controllerCloseTime),
                      child: IgnorePointer(
                        child: CustomFieldPrimary(
                          controller: controllerCloseTime,
                          title: AppText.closeTime,
                          label: "10:30 PM",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppValidator.validatorCloseTime;
                            }
                            return null;
                          },
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    AppSize.gapH15,

                    CustomFieldPrimary(
                      controller: controllerDeliveryCharge,
                      textInputType: TextInputType.numberWithOptions(),
                      textInputAction: TextInputAction.next,
                      title: AppText.deliveryChargeBDT,
                      label: AppText.deliveryChargeHint,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppValidator.validatorDeliveryCharge;
                        }
                        return null;
                      },
                    ),
                    AppSize.gapH15,

                    // Weekend Selector Component
                    CustomTitlePrimary(title: AppText.weekends),
                    CustomWeekendSelector(
                      initialSelectedDays: selectedWeekends.value,
                      onChanged: (csvDays) {
                        selectedWeekends.value = csvDays;
                      },
                    ),
                    AppSize.gapH80,

                    ValueListenableBuilder<bool>(
                      valueListenable: isFormChanged,
                      builder: (context, isChanged, child) {
                        return CustomButton(
                          onPressed: () {
                            if (isChanged) {
                              if (_profileShopEditKey.currentState!
                                  .validate()) {
                                context.read<ProfileUpdateShopBloc>().add(
                                  ProfileUpdateShopEventSubmit(
                                    ownerFirstName: controllerOwnerFirstName
                                        .text
                                        .trim(),
                                    ownerLastName: controllerOwnerLastName.text
                                        .trim(),
                                    shopAddress: controllerShopAddress.text
                                        .trim(),
                                    shopName: controllerShopName.text.trim(),
                                    openTime: controllerOpenTime.text.trim(),
                                    closeTime: controllerCloseTime.text.trim(),
                                    deliveryCharge: double.tryParse(
                                      controllerDeliveryCharge.text.trim(),
                                    )!,
                                    weekends: selectedWeekends.value,
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
