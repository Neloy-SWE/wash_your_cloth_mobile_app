/* 
Created by Neloy on 18 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_dialogue.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_laundry_icon.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_title.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';

import '../../../../../utilities/app_color.dart';
import '../../../../../utilities/app_tool.dart';
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
              List<Color> statusColorSet = getStatusBadgeColorSet(
                orderStatus: order.status,
              );
              return SingleChildScrollView(
                padding: AppSize.paddingAll25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // summary
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 3,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppSize.borderRadiusAll10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              CustomLaundryIcon(size: 70),

                              AppSize.gapH20,

                              Text(
                                order.trackingId,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),

                              AppSize.gapH15,

                              CustomStatusBadge(
                                statusColorSet: statusColorSet,
                                status: order.status,
                                fontSize: 14,
                              ),

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
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(color: AppColor.colorPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AppSize.gapH20,

                    // shop information
                    Text(
                      AppText.shopInformation,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    AppSize.gapH10,
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: AppSize.borderRadiusAll10,
                      ),
                      elevation: 3,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
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
                    ),
                    AppSize.gapH20,

                    Text(
                      AppText.orderItems,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    AppSize.gapH10,
                    ...order.orderItems.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppSize.borderRadiusAll10,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: AppColor.colorPrimary,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Text(
                                      "${item.totalPrice} ${AppText.bdtCapital}",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
                                    ),
                                  ],
                                ),

                                const Divider(),

                                _PriceRow(
                                  title: AppText.quantity,
                                  value: "${item.quantity}",
                                ),

                                _PriceRow(
                                  title: AppText.unitPrice,
                                  value:
                                      "${item.unitPrice} ${AppText.bdtCapital}",
                                ),

                                _PriceRow(
                                  title: AppText.ironPress,
                                  value: item.isIronPress
                                      ? AppText.yes
                                      : AppText.no,
                                ),

                                if (item.isIronPress)
                                  _PriceRow(
                                    title: AppText.ironCharge,
                                    value:
                                        "${item.ironPressPrice} ${AppText.bdtCapital}",
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    AppSize.gapH10,

                    Container(
                      padding: AppSize.paddingAll10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppSize.borderRadiusAll8,
                        border: Border.all(
                          color: AppColor.colorPrimary,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            AppText.grandTotal,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),

                          Text(
                            "${order.totalPrice} ${AppText.bdtCapital}",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),

                    AppSize.gapH20,
                  ],
                ),
              );
            } else if (state is OrderDetailsUserStateLoading) {
              return AppSize.noGap;
            } else {
              return Center(
                child: Icon(
                  Icons.not_interested,
                  size: 50,
                  color: AppColor.colorBackgroundCard,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String title;
  final String value;

  const _PriceRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppText.style.bodyMedium?.copyWith(
                color: AppColor.colorHint,
              ),
            ),
          ),

          Text(value, style: AppText.style.bodyMedium),
        ],
      ),
    );
  }
}
