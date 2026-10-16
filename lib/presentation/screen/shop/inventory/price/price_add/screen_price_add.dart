/* 
Created by Neloy on 09 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_text_field.dart';

import '../../../../../../utilities/app_size.dart';
import '../../../../../../utilities/app_text.dart';
import '../../../../../../utilities/app_validator.dart';
import '../../../../../custom_widget/custom_button.dart';

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
        child: SingleChildScrollView(
          padding: AppSize.paddingAll25,
          child: Form(
            key: _priceAddKey,
            child: Column(
              children: [
                CustomFieldDropdownSearch<String>(
                  title: AppText.selectService,
                  isRequired: true,
                  label: AppText.selectServiceHint,
                  controller: controllerService,
                  items: ["check 1", "check 2", "check 3"],
                  itemAsString: (value) => value,
                  maxMenuHeight: 250,
                  onSelected: (value) {},
                ),
                AppSize.gapH15,

                CustomFieldDropdownSearch<String>(
                  title: AppText.selectItem,
                  isRequired: true,
                  label: AppText.selectItemHint,
                  controller: controllerItem,
                  items: ["check 1", "check 2", "check 3"],
                  itemAsString: (value) => value,
                  maxMenuHeight: 250,
                  onSelected: (value) {},
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
                  onPressed: (){},
                  buttonText: AppText.add,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
