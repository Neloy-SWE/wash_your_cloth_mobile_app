/* 
Created by Neloy on 30 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utilities/app_color.dart';
import '../../../../../utilities/app_size.dart';
import '../../../../../utilities/app_text.dart';
import '../../../../custom_widget/custom_button.dart';
import '../../../../custom_widget/custom_card.dart';
import '../../../../custom_widget/custom_details_item.dart';
import '../../../../custom_widget/custom_dialogue.dart';
import '../../../../custom_widget/custom_not_found.dart';
import '../../../../custom_widget/custom_snack_bar.dart';
import 'bloc/price_list_shop_bloc.dart';

class ScreenInventoryPriceList extends StatefulWidget {
  const ScreenInventoryPriceList({super.key});

  @override
  State<ScreenInventoryPriceList> createState() =>
      _ScreenInventoryPriceListState();
}

class _ScreenInventoryPriceListState extends State<ScreenInventoryPriceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.inventory)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSize.paddingAll25,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {},
                      buttonText: AppText.manageService,
                      colorBorder: AppColor.colorPrimary,
                      colorButton: Colors.white,
                      colorText: AppColor.colorPrimary,
                    ),
                  ),
                  AppSize.gapW10,
                  Expanded(
                    child: CustomButton(
                      onPressed: () {},
                      buttonText: AppText.manageItem,
                      colorBorder: AppColor.colorPrimary,
                      colorButton: Colors.white,
                      colorText: AppColor.colorPrimary,
                    ),
                  ),
                ],
              ),
              AppSize.gapH20,
              const Divider(),

              BlocConsumer<PriceListShopBloc, PriceListShopState>(
                listener: (context, state) {
                  if (state is PriceListShopStateLoading) {
                    CallDialogue.showLoader(context);
                  } else if (state is PriceListShopStateFetch) {
                    if (!state.isActivating) {
                      CallDialogue.hideLoader(context);
                    }
                  } else if (state is PriceListShopStateError) {
                    CallDialogue.hideLoader(context);
                    CallDialogue.showResult(
                      context: context,
                      message: state.message,
                      onOk: () => CallDialogue.hideLoader(context),
                    );
                  } else if (state is PriceListShopStateActionResult) {
                    // CallDialogue.hideLoader(context);
                    CustomSnackBar.primary(
                      context: context,
                      contentText: state.message,
                      backgroundColor: state.isSuccess
                          ? AppColor.colorPrimary
                          : Colors.redAccent,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is PriceListShopStateFetch) {
                    if (state.priceList.isEmpty) {
                      return const CustomNotFound();
                    }
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppText.priceList,
                              style: AppText.style.titleMedium,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 20,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.colorBackgroundStatusPending,
                                borderRadius: AppSize.borderRadiusAll8,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                AppText.addNewPrice,
                                style: AppText.style.bodyLarge!.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppSize.gapH20,

                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.priceList.length,
                          separatorBuilder: (context, index) => AppSize.gapH20,
                          itemBuilder: (context, index) {
                            final price = state.priceList[index];
                            return CustomCard(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${price.itemName}: ${price.serviceName}",
                                          style: AppText.style.titleMedium,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            price.isActive
                                                ? AppText.active
                                                : AppText.inactive,
                                            style: AppText.style.bodySmall!
                                                .copyWith(color: Colors.black),
                                          ),
                                          AppSize.gapW05,
                                          Transform.scale(
                                            scale: 0.7,
                                            child: CupertinoSwitch(
                                              value: price.isActive,
                                              activeTrackColor:
                                                  AppColor.colorPrimary,
                                              onChanged: state.isActivating
                                                  ? null // Disable during pending request
                                                  : (value) {
                                                      _handlePriceActivation(
                                                        priceId: price.id,
                                                      );
                                                    },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  CustomDetailsItem(
                                    title: AppText.unitPrice,
                                    value:
                                        "${price.price.toStringAsFixed(2)} ${AppText.bdtCapital}",
                                  ),
                                  CustomDetailsItem(
                                    title: AppText.discount,
                                    value:
                                        "${price.discountPrice.toStringAsFixed(2)} ${AppText.bdtCapital}",
                                  ),
                                  CustomDetailsItem(
                                    title: AppText.ironCharge,
                                    value:
                                        "${price.ironPressPrice.toStringAsFixed(2)} ${AppText.bdtCapital}",
                                  ),
                                  const Divider(),
                                  ExpansionTile(
                                    tilePadding: EdgeInsets.zero,
                                    childrenPadding: EdgeInsets.zero,
                                    splashColor: Colors.transparent,
                                    title: Text(
                                      AppText.description,
                                      style: AppText.style.titleSmall,
                                    ),
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          price.description,
                                          style: AppText.style.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else if (state is PriceListShopStateLoading ||
                      state is PriceListShopStateInitial) {
                    return AppSize.noGap;
                  } else {
                    return const CustomNotFound();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handlePriceActivation({required String priceId}) {
    CallDialogue.showResult(
      context: context,
      message: AppText.priceActivationAlertMessage,
      onOk: () {
        CallDialogue.hideLoader(context); // Close confirmation alert first
        context.read<PriceListShopBloc>().add(
          PriceListShopEventActivation(priceId: priceId),
        );
        CallDialogue.showLoader(context);
      },
    );
  }
}
