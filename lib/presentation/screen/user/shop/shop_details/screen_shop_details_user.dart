/* 
Created by Neloy on 31 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/order/use_case_order_place.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_icon_frame.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_titled_divider.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_weekend_selector.dart';

import '../../../../../data/model/model_price_list_user.dart';
import '../../../../../router/app_router.dart';
import '../../../../../utilities/app_color.dart';
import '../../../../../utilities/app_constant.dart';
import '../../../../../utilities/app_size.dart';
import '../../../../../utilities/app_text.dart';
import '../../../../custom_widget/custom_card.dart';
import '../../../../custom_widget/custom_dialogue.dart';
import '../../../../custom_widget/custom_not_found.dart';
import '../../../../custom_widget/custom_status_badge.dart';
import '../../../../custom_widget/custom_title.dart';
import 'bloc/shop_details_user_bloc.dart';

class ScreenShopDetailsUser extends StatefulWidget {
  const ScreenShopDetailsUser({super.key});

  @override
  State<ScreenShopDetailsUser> createState() => _ScreenShopDetailsUserState();
}

class _ScreenShopDetailsUserState extends State<ScreenShopDetailsUser> {
  final Map<String, CartData> _cartItems = {};

  int get _cartItemCount => _cartItems.length;
  String shopId = "";
  double deliveryCharge = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.shopDetails)),
      floatingActionButton: _cartItemCount > 0
          ? FloatingActionButton(
              backgroundColor: AppColor.colorPrimary,
              onPressed: () {
                context.push(
                  AppRouter.screenCart,
                  extra: {
                    AppConstant.shopId: shopId,
                    AppConstant.items: _cartItems.values.toList(),
                    AppConstant.deliveryCharge: deliveryCharge,
                  },
                );
              },
              child: Badge(
                label: Text(
                  '$_cartItemCount',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: BlocConsumer<ShopDetailsUserBloc, ShopDetailsUserState>(
          listener: (context, state) {
            if (state is ShopDetailsUserStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is ShopDetailsUserStateFetch) {
              CallDialogue.hideLoader(context);
            } else if (state is ShopDetailsUserStateResult) {
              CallDialogue.hideLoader(context);
              CallDialogue.showResult(
                context: context,
                message: state.message,
                onOk: () => CallDialogue.hideLoader(context),
              );
            }
          },
          builder: (context, state) {
            if (state is ShopDetailsUserStateFetch) {
              final shop = state.shopDetailsUser;
              shopId = shop.id;
              deliveryCharge = shop.deliveryCharge;
              final priceList = state.priceList;
              return SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                  top: 25,
                  bottom: 65,
                ),
                child: Column(
                  children: [
                    // shop name, status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const CustomIconFrame(
                                size: 45,
                                iconData: Icons.storefront_rounded,
                              ),
                              AppSize.gapW10,
                              Expanded(
                                child: Text(
                                  shop.shopName,
                                  style: AppText.style.titleMedium!.copyWith(
                                    color: AppColor.colorPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppSize.gapW10,
                        CustomStatusBadge(
                          status: shop.status ? AppText.open : AppText.close,
                          isBorder: false,
                          fontSize: 11,
                        ),
                      ],
                    ),
                    AppSize.gapH20,
                    CustomCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          CustomTitleWithIconValue(
                            title: AppText.owner,
                            iconData: Icons.account_circle_outlined,
                            value:
                                '${shop.ownerFirstName} ${shop.ownerLastName}',
                          ),
                          const Divider(),
                          CustomTitleWithIconValue(
                            iconData: Icons.location_on,
                            title: AppText.address,
                            value: shop.shopAddress,
                          ),
                          const Divider(),
                          CustomTitleWithIconValue(
                            iconData: Icons.phone,
                            title: AppText.phone,
                            value: shop.shopPhone,
                          ),
                          const Divider(),
                          CustomTitleWithIconValue(
                            iconData: Icons.work_history_outlined,
                            title: AppText.businessHours,
                            value: '${shop.openTime} - ${shop.closeTime}',
                          ),
                          const Divider(),
                          CustomTitleWithIconValue(
                            iconData: Icons.money,
                            title: AppText.deliveryCharge,
                            value:
                                '${shop.deliveryCharge} ${AppText.bdtCapital}',
                          ),
                        ],
                      ),
                    ),
                    AppSize.gapH20,

                    CustomTitledDivider(title: AppText.weekends),
                    CustomWeekendSelector(initialSelectedDays: shop.weekends),
                    AppSize.gapH20,

                    // Price List
                    CustomTitledDivider(title: AppText.priceList),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final price = priceList[index];
                        return PriceListItemCard(
                          price: price,
                          onItemChanged: (quantity, isIronPressed) {
                            setState(() {
                              if (quantity > 0) {
                                final hasDiscount =
                                    price.discountPrice > 0 &&
                                    price.discountPrice < price.price;
                                final effectivePrice = hasDiscount
                                    ? (price.price - price.discountPrice)
                                    : price.price;

                                _cartItems[price.id] = CartData(
                                  priceId: price.id,
                                  quantity: quantity,
                                  isIronPress: isIronPressed,
                                  unitPrice: effectivePrice,
                                  ironPressPrice: price.ironPressPrice,
                                  serviceName: price.serviceName,
                                  itemName: price.itemName,
                                );
                              } else {
                                _cartItems.remove(price.id);
                              }
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return AppSize.gapH10;
                      },
                      itemCount: priceList.length,
                    ),
                    AppSize.gapH35,
                  ],
                ),
              );
            } else if (state is ShopDetailsUserStateLoading) {
              return AppSize.noGap;
            } else {
              return const CustomNotFound();
            }
          },
        ),
      ),
    );
  }
}

class PriceListItemCard extends StatefulWidget {
  final ModelPriceListUser price;
  final Function(int quantity, bool isIronPressed) onItemChanged;

  const PriceListItemCard({
    super.key,
    required this.price,
    required this.onItemChanged,
  });

  @override
  State<PriceListItemCard> createState() => _PriceListItemCardState();
}

class _PriceListItemCardState extends State<PriceListItemCard> {
  int _quantity = 0;
  bool _isIronPressOn = false;

  void _increment() {
    setState(() {
      _quantity++;
    });
    widget.onItemChanged(_quantity, _isIronPressOn);
  }

  void _decrement() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
      widget.onItemChanged(_quantity, _isIronPressOn);
    }
  }

  void _toggleIronPress(bool value) {
    setState(() {
      _isIronPressOn = value;
    });
    widget.onItemChanged(_quantity, _isIronPressOn);
  }

  @override
  Widget build(BuildContext context) {
    final price = widget.price;
    final hasDiscount =
        price.discountPrice > 0 && price.discountPrice < price.price;
    final effectivePrice = hasDiscount
        ? (price.price - price.discountPrice)
        : price.price;

    return CustomCard(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${price.itemName}: ${price.serviceName}",
                  style: AppText.style.titleMedium,
                ),
                AppSize.gapH10,
                Row(
                  children: [
                    Text(
                      "${AppText.unitPrice}: ",
                      style: AppText.style.titleMedium?.copyWith(fontSize: 16),
                    ),
                    Text(
                      "${effectivePrice.toStringAsFixed(2)} ${AppText.bdtCapital}",
                      style: AppText.style.titleMedium?.copyWith(
                        color: AppColor.colorPrimary,
                        fontSize: 16,
                      ),
                    ),
                    if (hasDiscount) ...[
                      AppSize.gapW05,
                      Text(
                        "${price.price.toStringAsFixed(2)} ${AppText.bdtCapital}",
                        style: AppText.style.bodySmall?.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                if (_isIronPressOn) ...[
                  AppSize.gapH05,
                  Row(
                    children: [
                      Text(
                        "${AppText.ironCharge}: ",
                        style: AppText.style.titleMedium?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${price.ironPressPrice.toStringAsFixed(2)} ${AppText.bdtCapital}",
                        style: AppText.style.titleMedium?.copyWith(
                          color: AppColor.colorPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
                AppSize.gapH05,
              ],
            ),
          ),
          AppSize.gapW05,

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppSize.gapH05,
              _quantity == 0
                  ? Container(
                      height: 36,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppSize.borderRadiusAll10,
                        border: Border.all(color: Colors.black),
                      ),
                      child: InkWell(
                        borderRadius: AppSize.borderRadiusAll10,
                        onTap: _increment,
                        child: const Center(
                          child: Icon(Icons.add, color: Colors.black, size: 20),
                        ),
                      ),
                    )
                  : Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppSize.borderRadiusAll10,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 30,
                              minHeight: 36,
                            ),
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.black,
                              size: 18,
                            ),
                            onPressed: _decrement,
                          ),
                          Text(
                            '$_quantity',
                            style: AppText.style.titleMedium?.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 30,
                              minHeight: 36,
                            ),
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 18,
                            ),
                            onPressed: _increment,
                          ),
                        ],
                      ),
                    ),
              AppSize.gapH05,
              _quantity != 0
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppText.ironPressColon,
                          style: AppText.style.bodyMedium?.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        AppSize.gapW05,
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            value: _isIronPressOn,
                            activeTrackColor: AppColor.colorPrimary,
                            onChanged: _toggleIronPress,
                          ),
                        ),
                      ],
                    )
                  : AppSize.noGap,
            ],
          ),
        ],
      ),
    );
  }
}
