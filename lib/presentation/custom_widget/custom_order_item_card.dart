/* 
Created by Neloy on 20 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_card.dart';

import '../../data/model/model_order_list.dart';
import '../../utilities/app_color.dart';
import '../../utilities/app_size.dart';
import '../../utilities/app_text.dart';
import 'custom_icon_frame.dart';
import 'custom_status_badge.dart';

class CustomOrderItemCard extends StatelessWidget {
  final void Function() onTap;
  final ModelOrderList order;

  const CustomOrderItemCard({
    super.key,
    required this.onTap,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardWithAction(
      onTap: onTap,
      child: Row(
        children: [
          CustomIconFrame(
            size: 48,
            iconData: Icons.local_laundry_service_rounded,
          ),
          AppSize.gapW15,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.trackingId,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.style.titleSmall!.copyWith(fontSize: 15),
                ),

                AppSize.gapH10,

                Text(AppText.totalAmount, style: AppText.style.bodySmall),

                AppSize.gapH03,

                Text(
                  "${order.totalPrice} ${AppText.bdtCapital}",
                  style: AppText.style.titleMedium!.copyWith(
                    color: AppColor.colorPrimary,
                  ),
                ),
              ],
            ),
          ),
          AppSize.gapW05,

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomStatusBadge(status: order.status),

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
    );
  }
}
