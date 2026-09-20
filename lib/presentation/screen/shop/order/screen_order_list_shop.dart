/* 
Created by Neloy on 19 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/app_size.dart';
import '../../../custom_widget/custom_dialogue.dart';
import '../../../custom_widget/custom_not_found.dart';
import '../../../custom_widget/custom_order_item_card.dart';
import 'bloc/order_list_shop_bloc.dart';

class ScreenOrderListShop extends StatelessWidget {
  const ScreenOrderListShop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderListShopBloc, OrderListShopState>(
      listener: (context, state) {
        if (state is OrderListShopStateLoading) {
          CallDialogue.showLoader(context);
        } else if (state is OrderListShopStateFetch) {
          CallDialogue.hideLoader(context);
        } else if (state is OrderListShopStateResult) {
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
        if (state is OrderListShopStateFetch) {
          if (state.orderList.isEmpty) {
            return CustomNotFound();
          }
          return ListView.separated(
            padding: AppSize.paddingAll25,
            itemBuilder: (context, index) {
              final order = state.orderList[index];
              return CustomOrderItemCard(
                order: order,
                // onTap: () => context.push(
                //   AppRouter.screenOrderDetailsShop,
                //   extra: order.id,
                // ),
                onTap: () {},
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return AppSize.gapH20;
            },
            itemCount: state.orderList.length,
          );
        } else {
          return CustomNotFound();
        }
      },
    );
  }
}
