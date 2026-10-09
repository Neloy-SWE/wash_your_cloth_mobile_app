/* 
Created by Neloy on 04 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';

import '../../../../../../utilities/app_color.dart';
import '../../../../../../utilities/app_constant.dart';
import '../../../../../../utilities/app_validator.dart';
import '../../../../../custom_widget/custom_button.dart';
import '../../../../../custom_widget/custom_dialogue.dart';
import '../../../../../custom_widget/custom_snack_bar.dart';
import '../../../../../custom_widget/custom_text_field.dart';
import 'bloc/price_update_bloc.dart';

class ScreenPriceUpdate extends StatefulWidget {
  final double price;
  final double discountPrice;
  final double ironPressPrice;
  final String priceId;

  const ScreenPriceUpdate({
    super.key,
    required this.price,
    required this.discountPrice,
    required this.ironPressPrice,
    required this.priceId,
  });

  @override
  State<ScreenPriceUpdate> createState() => _ScreenPriceUpdateState();
}

class _ScreenPriceUpdateState extends State<ScreenPriceUpdate> {
  final _priceEditKey = GlobalKey<FormState>();

  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerDiscountPrice = TextEditingController();
  final TextEditingController controllerIronPressPrice =
      TextEditingController();

  final ValueNotifier<bool> isFormChanged = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    controllerPrice.text = widget.price.toString();
    controllerDiscountPrice.text = widget.discountPrice.toString();
    controllerIronPressPrice.text = widget.ironPressPrice.toString();

    controllerPrice.addListener(_checkIsChanged);
    controllerDiscountPrice.addListener(_checkIsChanged);
    controllerIronPressPrice.addListener(_checkIsChanged);
  }

  void _checkIsChanged() {
    final hasChanged =
        controllerPrice.text.trim() != widget.price.toString() ||
        controllerDiscountPrice.text.trim() !=
            widget.discountPrice.toString() ||
        controllerIronPressPrice.text.trim() !=
            widget.ironPressPrice.toString();

    if (isFormChanged.value != hasChanged) {
      isFormChanged.value = hasChanged;
    }
  }

  @override
  void dispose() {
    controllerPrice.removeListener(_checkIsChanged);
    controllerDiscountPrice.removeListener(_checkIsChanged);
    controllerIronPressPrice.removeListener(_checkIsChanged);
    controllerPrice.dispose();
    controllerDiscountPrice.dispose();
    controllerIronPressPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.updatePrice)),
      body: SafeArea(
        child: BlocConsumer<PriceUpdateBloc, PriceUpdateState>(
          listener: (context, state) {
            if (state is PriceUpdateStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is PriceUpdateStateResult) {
              CallDialogue.hideLoader(context);
              if (state.isNavigate) {
                CustomSnackBar.primary(
                  context: context,
                  contentText: state.message,
                );
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted && context.canPop()) {
                    context.pop({
                      AppConstant.price: double.parse(
                        controllerPrice.text.trim(),
                      ),
                      AppConstant.discountPrice: double.parse(
                        controllerDiscountPrice.text.trim(),
                      ),
                      AppConstant.ironPressPrice: double.parse(
                        controllerIronPressPrice.text.trim(),
                      ),
                    });
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
                key: _priceEditKey,
                child: Column(
                  children: [
                    CustomFieldPrimary(
                      controller: controllerPrice,
                      textInputType: TextInputType.numberWithOptions(),
                      textInputAction: TextInputAction.next,
                      title: AppText.priceBDT,
                      isRequired: true,
                      label: AppText.priceHint,
                      validator: (value) {
                        if (!AppValidator.isAmount(value)) {
                          return AppValidator.validatorPrice;
                        }
                        return null;
                      },
                    ),
                    AppSize.gapH15,

                    CustomFieldPrimary(
                      controller: controllerDiscountPrice,
                      textInputType: TextInputType.numberWithOptions(),
                      textInputAction: TextInputAction.next,
                      title: AppText.discountPriceBDT,
                      isRequired: true,
                      label: AppText.priceHint,
                      validator: (value) {
                        if (!AppValidator.isAmount(value)) {
                          return AppValidator.validatorDiscountPrice;
                        }
                        return null;
                      },
                    ),
                    AppSize.gapH15,

                    CustomFieldPrimary(
                      controller: controllerIronPressPrice,
                      textInputType: TextInputType.numberWithOptions(),
                      textInputAction: TextInputAction.next,
                      title: AppText.ironPressPriceBDT,
                      isRequired: true,
                      label: AppText.priceHint,
                      validator: (value) {
                        if (!AppValidator.isAmount(value)) {
                          return AppValidator.validatorIronPressPrice;
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
                              if (_priceEditKey.currentState!.validate()) {
                                context.read<PriceUpdateBloc>().add(
                                  PriceUpdateEventSubmit(
                                    price: double.parse(
                                      controllerPrice.text.trim(),
                                    ),
                                    discountPrice: double.parse(
                                      controllerDiscountPrice.text.trim(),
                                    ),
                                    ironPressPrice: double.parse(
                                      controllerIronPressPrice.text.trim(),
                                    ),
                                    priceId: widget.priceId,
                                  ),
                                );
                              }
                            } else {
                              CustomSnackBar.primary(
                                context: context,
                                contentText: AppValidator.validatorPriceUpdate,
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
