/* 
Created by Neloy on 19 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../router/app_router.dart';
import '../../../../../utilities/app_color.dart';
import '../../../../../utilities/app_helper.dart';
import '../../../../../utilities/app_size.dart';
import '../../../../../utilities/app_text.dart';
import '../../../../custom_widget/custom_button.dart';
import '../../../../custom_widget/custom_card.dart';
import '../../../../custom_widget/custom_dialogue.dart';
import '../../../../custom_widget/custom_icon_frame.dart';
import '../../../../custom_widget/custom_not_found.dart';
import '../../../../custom_widget/custom_title.dart';
import '../../../../custom_widget/custom_titled_divider.dart';
import 'bloc/profile_view_shop_bloc.dart';

class ScreenProfileShop extends StatefulWidget {
  const ScreenProfileShop({super.key});

  @override
  State<ScreenProfileShop> createState() => _ScreenProfileShopState();
}

class _ScreenProfileShopState extends State<ScreenProfileShop> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewShopBloc, ProfileViewShopState>(
      listener: (context, state) {
        if (state is ProfileViewShopStateLoading) {
          CallDialogue.showLoader(context);
        } else if (state is ProfileViewShopStateFetch) {
          CallDialogue.hideLoader(context);
        } else if (state is ProfileViewShopStateResult) {
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
        if (state is ProfileViewShopStateFetch) {
          final profile = state.profileViewShop;
          final summaryItems = profile.ordersSummary.toItemList();

          return SingleChildScrollView(
            padding: AppSize.paddingAll25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomIconFrame(
                        size: 50,
                        iconData: Icons.storefront_rounded,
                      ),
                      AppSize.gapW10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.shopName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.style.titleMedium?.copyWith(
                                color: AppColor.colorPrimary,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppText.shopActiveStatus,
                                  style: AppText.style.bodyMedium?.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                Transform.scale(
                                  scale: 0.5,
                                  child: CupertinoSwitch(
                                    value: profile.status,
                                    activeTrackColor: AppColor.colorPrimary,
                                    onChanged: (value) {
                                      setState(() {
                                        profile.status = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      AppSize.gapW10,
                      IconButton(
                        onPressed: () {
                          // Navigate to Shop Profile Edit Screen
                        },
                        icon: const Icon(Icons.edit_note),
                      ),
                    ],
                  ),
                ),
                AppSize.gapH20,

                CustomCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.colorBackgroundCard,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.account_balance_wallet_outlined,
                              color: AppColor.colorPrimary,
                              size: 24,
                            ),
                          ),
                          AppSize.gapW10,
                          Text(
                            AppText.totalAmount,
                            style: AppText.style.titleMedium,
                          ),
                        ],
                      ),
                      Text(
                        "${profile.totalIncome.toStringAsFixed(2)} ${AppText.bdtCapital}",
                        style: AppText.style.titleMedium?.copyWith(
                          color: AppColor.colorPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSize.gapH10,

                const CustomTitledDivider(title: AppText.ordersOverview),
                AppSize.gapH10,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: summaryItems.length,
                  itemBuilder: (context, index) {
                    final item = summaryItems[index];
                    return Container(
                      padding: AppSize.paddingAll10,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: item.color,
                          width: 1,
                        ),
                        borderRadius: AppSize.borderRadiusAll8,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: AppText.style.bodyLarge,
                          ),
                          AppSize.gapH05,
                          Text(
                            '${item.count}',
                            style: AppText.style.titleLarge?.copyWith(
                              color: item.color,
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                ),
                AppSize.gapH10,

                const CustomTitledDivider(title: AppText.shopInformation),
                AppSize.gapH10,

                CustomCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CustomTitleWithIconValue(
                        iconData: Icons.account_circle_outlined,
                        title: AppText.owner,
                        value:
                            "${profile.ownerFirstName} ${profile.ownerLastName}",
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTitleWithIconValue(
                              iconData: Icons.phone,
                              title: AppText.phone,
                              value: hidePhoneOrEmail(
                                phoneOrEmail: profile.shopPhone,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.push(AppRouter.screenChangePhone);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: AppColor.colorPrimary,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      CustomTitleWithIconValue(
                        iconData: Icons.location_on,
                        title: AppText.address,
                        value: profile.shopAddress,
                      ),
                      const Divider(),
                      CustomTitleWithIconValue(
                        iconData: Icons.work_history_outlined,
                        title: AppText.businessHours,
                        value: "${profile.openTime} - ${profile.closeTime}",
                      ),
                      const Divider(),
                      CustomTitleWithIconValue(
                        iconData: Icons.calendar_month_outlined,
                        title: AppText.weekends,
                        value: profile.weekends,
                      ),
                      const Divider(),
                      CustomTitleWithIconValue(
                        iconData: Icons.local_shipping_outlined,
                        title: AppText.deliveryCharge,
                        value:
                            "${profile.deliveryCharge.toStringAsFixed(2)} ${AppText.bdtCapital}",
                      ),
                    ],
                  ),
                ),
                AppSize.gapH50,
                CustomButton(
                  onPressed: () {
                    context.push(AppRouter.screenChangePassword);
                  },
                  buttonText: AppText.changePassword,
                ),
                AppSize.gapH20,
                CustomButton(
                  onPressed: () {
                    // context.go(AppRouter.screenAuthLogin);
                  },
                  buttonText: AppText.logout,
                  textColor: AppColor.colorDanger,
                  colorButton: Colors.white,
                  colorBorder: AppColor.colorDanger,
                ),
                AppSize.gapH35,
              ],
            ),
          );
        } else if (state is ProfileViewShopStateLoading) {
          return AppSize.noGap;
        } else {
          return const CustomNotFound();
        }
      },
    );
  }
}
