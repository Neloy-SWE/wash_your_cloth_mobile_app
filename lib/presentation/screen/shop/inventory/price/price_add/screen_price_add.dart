/* 
Created by Neloy on 09 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_text_field.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';

import '../../../../../../data/model/model_item_list.dart';
import '../../../../../../data/model/model_service_list.dart';
import '../../../../../../utilities/app_size.dart';
import '../../../../../../utilities/app_text.dart';
import '../../../../../../utilities/app_validator.dart';
import '../../../../../custom_widget/custom_button.dart';
import '../../../../../custom_widget/custom_dialogue.dart';
import '../../../../../custom_widget/custom_snack_bar.dart';
import 'bloc/price_add_bloc.dart';

class ScreenPriceAdd extends StatefulWidget {
  const ScreenPriceAdd({super.key});

  @override
  State<ScreenPriceAdd> createState() => _ScreenPriceAddState();
}

class _ScreenPriceAddState extends State<ScreenPriceAdd> {
  final _priceAddKey = GlobalKey<FormState>();
  final TextEditingController controllerService = TextEditingController();
  final TextEditingController controllerItem = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerDiscountPrice = TextEditingController();
  final TextEditingController controllerIronPressPrice =
      TextEditingController();

  String selectedServiceId = "";
  String selectedItemId = "";

  List<ModelServiceList> serviceList = [];
  List<ModelItemList> itemList = [];

  @override
  void dispose() {
    controllerService.dispose();
    controllerItem.dispose();
    controllerPrice.dispose();
    controllerDiscountPrice.dispose();
    controllerIronPressPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.addNewPrice)),
      body: SafeArea(
        child: BlocConsumer<PriceAddBloc, PriceAddState>(
          listener: (context, state) {
            if (state is PriceAddStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is PriceAddStateDropdownDataLoaded) {
              if (serviceList.isEmpty) {
                serviceList = state.serviceList;
              }
              if (itemList.isEmpty) {
                itemList = state.itemList;
              }
              if (state.isNavigate) {
                CallDialogue.hideLoader(context);
                CustomSnackBar.primary(
                  context: context,
                  contentText: state.message,
                );
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted && context.canPop()) {
                    context.pop(true);
                  }
                });
              } else if (state.message.isNotEmpty) {
                CallDialogue.hideLoader(context);
                CallDialogue.showResult(
                  context: context,
                  message: state.message,
                  onOk: () => CallDialogue.hideLoader(context),
                );
              } else if (state.needLoader) {
                CallDialogue.showLoader(context);
              } else {
                CallDialogue.hideLoader(context);
              }
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: AppSize.paddingAll25,
              child: Form(
                key: _priceAddKey,
                child: Column(
                  children: [
                    CustomFieldDropdownSearch<ModelServiceList>(
                      title: AppText.selectService,
                      isRequired: true,
                      label: AppText.selectServiceHint,
                      controller: controllerService,
                      items: serviceList,
                      itemAsString: (value) => value.serviceName,
                      maxMenuHeight: 250,
                      onSelected: (value) {
                        selectedServiceId = value!.id;
                      },
                    ),
                    AppSize.gapH15,

                    CustomFieldDropdownSearch<ModelItemList>(
                      title: AppText.selectItem,
                      isRequired: true,
                      label: AppText.selectItemHint,
                      controller: controllerItem,
                      items: itemList,
                      itemAsString: (value) => value.itemName,
                      maxMenuHeight: 250,
                      onSelected: (value) {
                        selectedItemId = value!.id;
                      },
                      // validator: (value){
                      //   if (value == null || value.isEmpty){
                      //     return AppValidator.validatorInvalidDropdownSelect;
                      //   }
                      //   return null;
                      // },
                    ),
                    AppSize.gapH15,

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

                    CustomButton(
                      onPressed: () {
                        if (_priceAddKey.currentState!.validate()) {
                          if (selectedServiceId.isNotEmpty &&
                              selectedItemId.isNotEmpty) {
                            context.read<PriceAddBloc>().add(
                              PriceAddEventSubmit(
                                serviceId: selectedServiceId,
                                itemId: selectedItemId,
                                price: double.parse(
                                  controllerPrice.text.trim(),
                                ),
                                discountPrice: double.parse(
                                  controllerDiscountPrice.text.trim(),
                                ),
                                ironPressPrice: double.parse(
                                  controllerIronPressPrice.text.trim(),
                                ),
                              ),
                            );
                          } else {
                            CustomSnackBar.primary(
                              context: context,
                              backgroundColor: AppColor.colorDanger,
                              contentText: AppValidator.validatorFieldFillup,
                            );
                          }
                        }
                      },
                      buttonText: AppText.add,
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
