/* 
Created by Neloy on 22 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/order/use_case_order_place.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_button.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_textfield.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/cart/bloc/order_place_bloc.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';

import '../../../../router/app_router.dart';
import '../../../../utilities/app_color.dart';
import '../../../../utilities/app_text.dart';
import '../../../custom_widget/custom_card.dart';
import '../../../custom_widget/custom_details_item.dart';
import '../../../custom_widget/custom_dialogue.dart';
import '../../../custom_widget/custom_snack_bar.dart';
import '../order/order_list/bloc/order_list_user_bloc.dart';

class ScreenCart extends StatelessWidget {
  final String shopId;
  final double deliveryCharge;
  final List<CartData> items;

  ScreenCart({
    super.key,
    required this.shopId,
    required this.items,
    required this.deliveryCharge,
  });

  final TextEditingController controllerNote = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double grandTotal = items.fold(0, (sum, item) {
      final ironPressPrice = item.isIronPress ? item.ironPressPrice : 0;
      return sum + (item.unitPrice + ironPressPrice) * item.quantity;
    });

    return Scaffold(
      appBar: AppBar(title: Text(AppText.cart)),
      body: SafeArea(
        child: BlocConsumer<OrderPlaceBloc, OrderPlaceState>(
          listener: (context, state) {
            if (state is OrderPlaceStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is OrderPlaceStateResult) {
              CallDialogue.hideLoader(context);
              if (state.isNavigate) {
                CustomSnackBar.primary(
                  context: context,
                  contentText: state.message,
                );
                context.read<OrderListUserBloc>().add(
                  OrderListUserEventFetch(),
                );
                context.go(AppRouter.screenOrderListUser);
              } else {
                CallDialogue.showResult(
                  context: context,
                  message: state.message,
                  onOk: () => CallDialogue.hideLoader(context),
                );
              }
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: AppSize.paddingAll25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.orderSummary,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppSize.gapH10,
                  ...items.map((item) {
                    final ironPressPrice = item.isIronPress
                        ? item.ironPressPrice
                        : 0;
                    final totalPrice =
                        (item.unitPrice + ironPressPrice) * item.quantity;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CustomCard(
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
                                        style: AppText.style.bodyMedium
                                            ?.copyWith(
                                              color: AppColor.colorPrimary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "$totalPrice ${AppText.bdtCapital}",
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
                              value: "${item.unitPrice} ${AppText.bdtCapital}",
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
                    );
                  }),
                  AppSize.gapH10,
                  CustomDetailsItemWithCard(
                    title: AppText.deliveryCharge,
                    value: "$deliveryCharge ${AppText.bdtCapital}",
                  ),
                  AppSize.gapH20,
                  CustomResultItem(
                    title: AppText.grandTotal,
                    value:
                        "${grandTotal + deliveryCharge} ${AppText.bdtCapital}",
                  ),
                  AppSize.gapH20,
                  CustomFieldPrimary(
                    controller: controllerNote,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    isArea: true,
                    title: AppText.note,
                    label: AppText.noteHint,
                    isRequired: false,
                    inputFormatters: [LengthLimitingTextInputFormatter(500)],
                  ),
                  AppSize.gapH35,
                  CustomButton(
                    onPressed: () => _placeOrder(context),
                    buttonText: AppText.placeOrder,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _placeOrder(BuildContext context) {
    final orderPlaceData = OrderPlaceData(
      shopId: shopId,
      note: controllerNote.text,
      items: items
          .map(
            (item) => ItemData(
              priceId: item.priceId,
              quantity: item.quantity,
              isIronPress: item.isIronPress,
            ),
          )
          .toList(),
    );

    context.read<OrderPlaceBloc>().add(
      OrderPlaceEventSubmit(orderPlaceData: orderPlaceData),
    );
  }
}
