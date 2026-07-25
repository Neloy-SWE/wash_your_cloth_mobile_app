/* 
Created by Neloy on 13 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_shop_list.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_icon_frame.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_status_badge.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';

import '../../../../utilities/app_color.dart';
import '../../../../utilities/app_size.dart';
import '../../../custom_widget/custom_dialogue.dart';
import '../../../custom_widget/custom_title.dart';
import 'bloc/shop_list_bloc.dart';

class ScreenShopList extends StatelessWidget {
  const ScreenShopList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopListBloc, ShopListState>(
      listener: (context, state) {
        if (state is ShopListStateLoading) {
          CallDialogue.showLoader(context);
        } else if (state is ShopListStateFetch) {
          CallDialogue.hideLoader(context);
        } else if (state is ShopListStateResult) {
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
        if (state is ShopListStateFetch) {
          return ListView.separated(
            padding: AppSize.paddingAll25,
            itemBuilder: (BuildContext context, int index) {
              final shop = state.shopList[index];
              return _shopListItemCard(shop: shop);
            },
            separatorBuilder: (BuildContext context, int index) {
              return AppSize.gapH20;
            },
            itemCount: state.shopList.length,
          );
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
    );
  }

  Widget _shopListItemCard({required ModelSopList shop}) {
    return InkWell(
      onTap: () {},
      borderRadius: AppSize.borderRadiusAll10,
      child: Container(
        padding: AppSize.paddingAll10,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconFrame(size: 48, iconData: Icons.storefront_rounded),
            AppSize.gapW15,

            // 2. Shop Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shop Name & Status Badge Row
                  Text(shop.shopName, style: AppText.style.titleMedium),
                  AppSize.gapH10,

                  CustomTitleWithIconValue(
                    iconData: Icons.location_on,
                    title: AppText.address,
                    value: shop.shopAddress,
                  ),
                ],
              ),
            ),
            AppSize.gapH10,

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomStatusBadge(
                  status: shop.status ? AppText.open : AppText.close,
                  isBorder: false,
                  fontSize: 11,
                ),

                AppSize.gapH15,

                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
