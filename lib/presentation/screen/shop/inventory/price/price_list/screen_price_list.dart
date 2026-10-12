/* 
Created by Neloy on 30 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../router/app_router.dart';
import '../../../../../../utilities/app_color.dart';
import '../../../../../../utilities/app_constant.dart';
import '../../../../../../utilities/app_size.dart';
import '../../../../../../utilities/app_text.dart';
import '../../../../../custom_widget/custom_button.dart';
import '../../../../../custom_widget/custom_card.dart';
import '../../../../../custom_widget/custom_details_item.dart';
import '../../../../../custom_widget/custom_dialogue.dart';
import '../../../../../custom_widget/custom_list_header.dart';
import '../../../../../custom_widget/custom_not_found.dart';
import '../../../../../custom_widget/custom_snack_bar.dart';
import '../price_list/bloc/price_list_shop_bloc.dart';

class ScreenPriceList extends StatelessWidget {
  const ScreenPriceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.inventory),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSize.paddingAll25,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () =>
                          context.push(AppRouter.screenServiceList),
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

              CustomListHeader(
                textListName: AppText.priceList,
                onTap: () => context.push(AppRouter.screenPriceAdd),
                textAddNewListName: AppText.addNewPrice,
              ),
              AppSize.gapH20,

              BlocConsumer<PriceListShopBloc, PriceListShopState>(
                listener: (context, state) {
                  if (state is PriceListShopStateLoading) {
                    CallDialogue.showLoader(context);
                  } else if (state is PriceListShopStateFetch) {
                    if (!state.isActivating && !state.isUpdating) {
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
                    return ListView.separated(
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
                                      Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Transform.scale(
                                            scale: 0.5,
                                            child: CupertinoSwitch(
                                              value: price.isActive,
                                              activeTrackColor:
                                                  AppColor.colorPrimary,
                                              onChanged: state.isActivating
                                                  ? null // Disable during pending request
                                                  : (value) {
                                                      _handlePriceActivation(
                                                        context: context,
                                                        priceId: price.id,
                                                      );
                                                    },
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Text(
                                              price.isActive
                                                  ? AppText.active
                                                  : AppText.inactive,
                                              style: AppText.style.bodyLarge!
                                                  .copyWith(fontSize: 8),
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context.push(
                                            AppRouter.screenPriceUpdate,
                                            extra: {
                                              AppConstant.price: price.price,
                                              AppConstant.discountPrice:
                                                  price.discountPrice,
                                              AppConstant.ironPressPrice:
                                                  price.ironPressPrice,
                                              AppConstant.priceId: price.id,
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.edit, size: 16),
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

  void _handlePriceActivation({
    required BuildContext context,
    required String priceId,
  }) {
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
