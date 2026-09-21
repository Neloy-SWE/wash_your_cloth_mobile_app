/* 
Created by Neloy on 13 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../router/app_router.dart';
import '../../../../../utilities/app_size.dart';
import '../../../../custom_widget/custom_dialogue.dart';
import '../../../../custom_widget/custom_not_found.dart';
import '../../../../custom_widget/custom_order_item_card.dart';
import 'bloc/order_list_user_bloc.dart';

class ScreenOrderListUser extends StatelessWidget {
  const ScreenOrderListUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderListUserBloc, OrderListUserState>(
      listener: (context, state) {
        if (state is OrderListUserStateLoading) {
          CallDialogue.showLoader(context);
        } else if (state is OrderListUserStateFetch) {
          CallDialogue.hideLoader(context);
        } else if (state is OrderListUserStateResult) {
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
        if (state is OrderListUserStateFetch) {
          if (state.orderList.isEmpty) {
            return CustomNotFound();
          }
          return ListView.separated(
            padding: AppSize.paddingAll25,
            itemBuilder: (context, index) {
              final order = state.orderList[index];
              return CustomOrderItemCard(
                order: order,
                onTap: () => context.push(
                  AppRouter.screenOrderDetailsUser,
                  extra: order.id,
                ),
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
