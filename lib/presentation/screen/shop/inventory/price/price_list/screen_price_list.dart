/* 
Created by Neloy on 30 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../data/model/model_price_list_shop.dart';
import '../../../../../../router/app_router.dart';
import '../../../../../../utilities/app_color.dart';
import '../../../../../../utilities/app_constant.dart';
import '../../../../../../utilities/app_size.dart';
import '../../../../../../utilities/app_text.dart';
import '../../../../../../utilities/app_validator.dart';
import '../../../../../custom_widget/custom_button.dart';
import '../../../../../custom_widget/custom_card.dart';
import '../../../../../custom_widget/custom_details_item.dart';
import '../../../../../custom_widget/custom_dialogue.dart';
import '../../../../../custom_widget/custom_list_header.dart';
import '../../../../../custom_widget/custom_not_found.dart';
import '../../../../../custom_widget/custom_pagination_footer.dart';
import '../../../../../custom_widget/custom_snack_bar.dart';
import '../../../../../custom_widget/custom_text_field.dart';
import '../price_list/bloc/price_list_shop_bloc.dart';

class ScreenPriceList extends StatefulWidget {
  const ScreenPriceList({super.key});

  @override
  State<ScreenPriceList> createState() => _ScreenPriceListState();
}

class _ScreenPriceListState extends State<ScreenPriceList> {
  bool _isLoaderVisible = false;
  final TextEditingController _searchController = TextEditingController();

  void _hideLoaderIfVisible() {
    if (!_isLoaderVisible) return;
    _isLoaderVisible = false;
    CallDialogue.hideLoader(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColor.colorPrimary,
          onRefresh: () async {
            final bloc = context.read<PriceListShopBloc>();
            final loaded = bloc.stream.firstWhere(
              (next) =>
                  next is PriceListShopStateFetch ||
                  next is PriceListShopStateError,
            );
            bloc.add(PriceListShopEventFetch(query: _searchController.text));
            await loaded;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: AppSize.paddingAll25,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => navigateToAddInventory(
                          context: context,
                          path: AppRouter.screenServiceList,
                        ),
                        buttonText: AppText.manageService,
                        colorBorder: AppColor.colorPrimary,
                        colorButton: Colors.white,
                        colorText: AppColor.colorPrimary,
                      ),
                    ),
                    AppSize.gapW10,
                    Expanded(
                      child: CustomButton(
                        onPressed: () => navigateToAddInventory(
                          context: context,
                          path: AppRouter.screenItemList,
                        ),
                        buttonText: AppText.manageItem,
                        colorBorder: AppColor.colorPrimary,
                        colorButton: Colors.white,
                        colorText: AppColor.colorPrimary,
                      ),
                    ),
                  ],
                ),
                AppSize.gapH20,
                const Divider(),

                CustomListHeader(
                  textListName: AppText.priceList,
                  onTap: () => navigateToAddInventory(
                    context: context,
                    path: AppRouter.screenPriceAdd,
                  ),
                  textAddNewListName: AppText.addNewPrice,
                ),
                AppSize.gapH20,
                CustomFieldPrimary(
                  controller: _searchController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  label: AppText.search,
                  isRequired: false,
                  prefixWidget: const Icon(Icons.search),
                  onChanged: (query) => context.read<PriceListShopBloc>().add(
                    PriceListShopEventFetch(query: query, debounce: true),
                  ),
                ),
                AppSize.gapH20,

                BlocConsumer<PriceListShopBloc, PriceListShopState>(
                  listener: (context, state) {
                    if (state is PriceListShopStateLoading) {
                      _isLoaderVisible = true;
                      CallDialogue.showLoader(context);
                    } else if (state is PriceListShopStateFetch) {
                      if (!state.isActivating && !state.isUpdating) {
                        _hideLoaderIfVisible();
                      }
                    } else if (state is PriceListShopStateError) {
                      _hideLoaderIfVisible();
                      CallDialogue.showResult(
                        context: context,
                        message: state.message,
                      );
                    } else if (state is PriceListShopStateActionResult) {
                      CustomSnackBar.primary(
                        context: context,
                        contentText: state.message,
                        backgroundColor: state.isSuccess
                            ? AppColor.colorPrimary
                            : Colors.redAccent,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is PriceListShopStateFetch) {
                      if (state.priceList.isEmpty) {
                        return state.search.isNotEmpty
                            ? Text(
                                AppText.noResultsFound,
                                style: AppText.style.bodySmall,
                              )
                            : const CustomNotFound();
                      }
                      return Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.priceList.length,
                            separatorBuilder: (context, index) =>
                                AppSize.gapH20,
                            itemBuilder: (context, index) {
                              final price = state.priceList[index];
                              return CustomCard(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${price.itemName}: ${price.serviceName}",
                                            style: AppText.style.titleMedium,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Stack(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              children: [
                                                Transform.scale(
                                                  scale: 0.5,
                                                  child: CupertinoSwitch(
                                                    value: price.isActive,
                                                    activeTrackColor:
                                                        AppColor.colorPrimary,
                                                    onChanged:
                                                        state.isActivating
                                                        ? null // Disable during pending request
                                                        : (value) {
                                                            _handlePriceActivation(
                                                              context: context,
                                                              priceId: price.id,
                                                            );
                                                          },
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Text(
                                                    price.isActive
                                                        ? AppText.active
                                                        : AppText.inactive,
                                                    style: AppText
                                                        .style
                                                        .bodyLarge!
                                                        .copyWith(fontSize: 8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () =>
                                                  navigateToUpdatePrice(
                                                    context: context,
                                                    price: price,
                                                  ),
                                              icon: Icon(Icons.edit, size: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    CustomDetailsItem(
                                      title: AppText.unitPrice,
                                      value:
                                          "${price.price.toStringAsFixed(2)} ${AppText.bdtCapital}",
                                    ),
                                    CustomDetailsItem(
                                      title: AppText.discount,
                                      value:
                                          "${price.discountPrice.toStringAsFixed(2)} ${AppText.bdtCapital}",
                                    ),
                                    CustomDetailsItem(
                                      title: AppText.ironCharge,
                                      value:
                                          "${price.ironPressPrice.toStringAsFixed(2)} ${AppText.bdtCapital}",
                                    ),
                                    const Divider(),
                                    ExpansionTile(
                                      tilePadding: EdgeInsets.zero,
                                      childrenPadding: EdgeInsets.zero,
                                      splashColor: Colors.transparent,
                                      title: Text(
                                        AppText.description,
                                        style: AppText.style.titleSmall,
                                      ),
                                      children: [
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text(
                                            price.description,
                                            style: AppText.style.bodyMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          AppSize.gapH20,
                          CustomPaginationFooter(
                            hasMore: state.hasMore,
                            isLoadingMore: state.isLoadingMore,
                            textLoadMoreError: state.loadMoreError,
                            onLoadMore: () => context
                                .read<PriceListShopBloc>()
                                .add(PriceListShopEventLoadMore()),
                          ),
                        ],
                      );
                    } else if (state is PriceListShopStateLoading ||
                        state is PriceListShopStateInitial) {
                      return AppSize.noGap;
                    } else {
                      return const CustomNotFound();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handlePriceActivation({
    required BuildContext context,
    required String priceId,
  }) {
    CallDialogue.showResult(
      context: context,
      message: AppText.priceActivationAlertMessage,
      onOk: () {
        CallDialogue.hideLoader(context); // Close confirmation alert first
        context.read<PriceListShopBloc>().add(
          PriceListShopEventActivation(priceId: priceId),
        );
        _isLoaderVisible = true;
        CallDialogue.showLoader(context);
      },
    );
  }

  Future<void> navigateToUpdatePrice({
    required BuildContext context,
    required ModelPriceListShop price,
  }) async {
    try {
      final Map? result = await context.push(
        AppRouter.screenPriceUpdate,
        extra: {
          AppConstant.price: price.price,
          AppConstant.discountPrice: price.discountPrice,
          AppConstant.ironPressPrice: price.ironPressPrice,
          AppConstant.priceId: price.id,
        },
      );

      if (result != null && context.mounted) {
        context.read<PriceListShopBloc>().add(
          PriceListShopEventUpdate(
            price: result[AppConstant.price],
            discountPrice: result[AppConstant.discountPrice],
            ironPressPrice: result[AppConstant.ironPressPrice],
            priceId: price.id,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackBar.primary(
          context: context,
          contentText: AppValidator.validatorPriceUpdateFail,
        );
      }
    }
  }

  Future<void> navigateToAddInventory({
    required BuildContext context,
    required String path,
  }) async {
    final bool? result = await context.push(path);
    if (result != null && result && context.mounted) {
      context.read<PriceListShopBloc>().add(PriceListShopEventFetch());
    }
  }
}
