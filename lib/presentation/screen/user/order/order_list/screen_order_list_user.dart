/* 
Created by Neloy on 13 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/order/order_list/bloc/order_list_user_bloc.dart';
import 'package:wash_your_cloth_mobile_app/router/app_router.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_tool.dart';

import '../../../../custom_widget/custom_dialogue.dart';

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
          return ListView.separated(
            padding: AppSize.paddingAll25,
            itemBuilder: (BuildContext context, int index) {
              List<Color> statusColorSet = getStatusBadgeColorSet(
                orderStatus: state.orderList[index].status,
              );
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  context.push(
                    AppRouter.screenOrderDetailsUser,
                    extra: state.orderList[index].id,
                  );
                },
                child: Container(
                  padding: AppSize.paddingAll10,
                  decoration: BoxDecoration(
                    color: AppColor.colorBackgroundCard,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColor.colorBackgroundIconTop,
                              AppColor.colorBackgroundIconBottom,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.local_laundry_service_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.orderList[index].trackingId,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.style.titleSmall!.copyWith(
                                fontSize: 15,
                              ),
                            ),

                            AppSize.gapH10,

                            Text(
                              AppText.totalAmount,
                              style: AppText.style.bodySmall,
                            ),

                            const SizedBox(height: 2),

                            Text(
                              "${state.orderList[index].totalPrice} ${AppText.bdtCapital}",
                              style: AppText.style.titleMedium!.copyWith(
                                color: AppColor.colorPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: statusColorSet[0],
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: statusColorSet[1]),
                            ),
                            child: Text(
                              state.orderList[index].status.toUpperCase(),
                              style: AppText.style.bodySmall!.copyWith(
                                color: statusColorSet[1],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

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
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 40);
            },
            itemCount: state.orderList.length,
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
}
