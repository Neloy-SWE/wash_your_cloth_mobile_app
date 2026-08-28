/* 
Created by Neloy on 18 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_card.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_details_item.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_dialogue.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_icon_frame.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_title.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';

import '../../../../../utilities/app_color.dart';
import '../../../../custom_widget/custom_not_found.dart';
import '../../../../custom_widget/custom_status_badge.dart';
import 'bloc/order_details_user_bloc.dart';

class ScreenOrderDetailsUser extends StatelessWidget {
  const ScreenOrderDetailsUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.orderDetails)),
      body: SafeArea(
        child: BlocConsumer<OrderDetailsUserBloc, OrderDetailsUserState>(
          listener: (context, state) {
            if (state is OrderDetailsUserStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is OrderDetailsUserStateFetch) {
              CallDialogue.hideLoader(context);
            } else if (state is OrderDetailsUserStateResult) {
              CallDialogue.hideLoader(context);

              CallDialogue.showResult(
                context: context,
                message: state.message,
                onOk: () => CallDialogue.hideLoader(context),
              );
            }
          },
          builder: (context, state) {
            if (state is OrderDetailsUserStateFetch) {
              final order = state.orderDetailsUser;
              return SingleChildScrollView(
                padding: AppSize.paddingAll25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // summary
                    CustomCard(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CustomIconFrame(
                            size: 70,
                            iconData: Icons.local_laundry_service_rounded,
                          ),

                          AppSize.gapH20,

                          Text(
                            order.trackingId,
                            textAlign: TextAlign.center,
                            style: AppText.style.titleSmall,
                          ),

                          AppSize.gapH15,

                          CustomStatusBadge(status: order.status, fontSize: 14),

                          AppSize.gapH20,

                          Text(
                            AppText.totalAmount,
                            style: AppText.style.bodySmall!.copyWith(
                              fontSize: 14,
                            ),
                          ),

                          AppSize.gapH10,

                          Text(
                            "${order.totalPrice} ${AppText.bdtCapital}",
                            style: AppText.style.titleLarge?.copyWith(
                              color: AppColor.colorPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSize.gapH20,

                    // shop information
                    Text(
                      AppText.shopInformation,
                      style: AppText.style.titleMedium,
                    ),
                    AppSize.gapH10,
                    CustomCard(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          CustomTitleWithIconValue(
                            title: AppText.shop,
                            iconData: Icons.store,
                            value: order.shopName,
                          ),

                          const Divider(),

                          CustomTitleWithIconValue(
                            iconData: Icons.person,
                            title: AppText.owner,
                            value:
                                "${order.ownerFirstName} ${order.ownerLastName}",
                          ),

                          const Divider(),

                          CustomTitleWithIconValue(
                            iconData: Icons.location_on,
                            title: AppText.address,
                            value: order.shopAddress,
                          ),

                          const Divider(),

                          CustomTitleWithIconValue(
                            iconData: Icons.phone,
                            title: AppText.phone,
                            value: order.shopPhone,
                          ),
                        ],
                      ),
                    ),
                    AppSize.gapH20,

                    if (order.note.isNotEmpty) ...[
                      Text(AppText.note, style: AppText.style.titleMedium),
                      AppSize.gapH10,
                      CustomCard(
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            order.note,
                            style: AppText.style.bodyMedium,
                          ),
                        ),
                      ),
                      AppSize.gapH20,
                    ],

                    Text(AppText.orderItems, style: AppText.style.titleMedium),
                    AppSize.gapH10,
                    ...order.orderItems.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CustomCard(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.itemName,
                                          style: AppText.style.titleSmall,
                                        ),

                                        Text(
                                          item.serviceName,
                                          style: AppText.style.bodyMedium
                                              ?.copyWith(
                                                color: AppColor.colorPrimary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Text(
                                    "${item.totalPrice} ${AppText.bdtCapital}",
                                    style: AppText.style.titleSmall,
                                  ),
                                ],
                              ),

                              const Divider(),

                              CustomDetailsItem(
                                title: AppText.quantity,
                                value: "${item.quantity}",
                              ),

                              CustomDetailsItem(
                                title: AppText.unitPrice,
                                value:
                                    "${item.unitPrice} ${AppText.bdtCapital}",
                              ),

                              CustomDetailsItem(
                                title: AppText.ironPress,
                                value: item.isIronPress
                                    ? AppText.yes
                                    : AppText.no,
                              ),

                              if (item.isIronPress)
                                CustomDetailsItem(
                                  title: AppText.ironCharge,
                                  value:
                                      "${item.ironPressPrice} ${AppText.bdtCapital}",
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AppSize.gapH10,

                    CustomDetailsItemWithCard(
                      title: AppText.deliveryCharge,
                      value: "${order.deliveryCharge} ${AppText.bdtCapital}",
                    ),
                    AppSize.gapH20,

                    CustomResultItem(
                      title: AppText.grandTotal,
                      value: "${order.totalPrice} ${AppText.bdtCapital}",
                    ),

                    AppSize.gapH20,
                  ],
                ),
              );
            } else if (state is OrderDetailsUserStateLoading) {
              return AppSize.noGap;
            } else {
              return CustomNotFound();
            }
          },
        ),
      ),
    );
  }
}
