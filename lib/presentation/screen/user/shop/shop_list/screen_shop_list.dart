/* 
Created by Neloy on 13 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_card.dart';

import '../../../../../data/model/model_shop_list.dart';
import '../../../../../router/app_router.dart';
import '../../../../../utilities/app_color.dart';
import '../../../../../utilities/app_size.dart';
import '../../../../../utilities/app_text.dart';
import '../../../../custom_widget/custom_dialogue.dart';
import '../../../../custom_widget/custom_icon_frame.dart';
import '../../../../custom_widget/custom_not_found.dart';
import '../../../../custom_widget/custom_status_badge.dart';
import '../../../../custom_widget/custom_pagination_footer.dart';
import '../../../../custom_widget/custom_text_field.dart';
import '../../../../custom_widget/custom_title.dart';
import 'bloc/shop_list_bloc.dart';

class ScreenShopList extends StatefulWidget {
  const ScreenShopList({super.key});

  @override
  State<ScreenShopList> createState() => _ScreenShopListState();
}

class _ScreenShopListState extends State<ScreenShopList> {
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
    return BlocConsumer<ShopListBloc, ShopListState>(
      listener: (context, state) {
        if (state is ShopListStateLoading) {
          _isLoaderVisible = true;
          CallDialogue.showLoader(context);
        } else if (state is ShopListStateFetch) {
          _hideLoaderIfVisible();
        } else if (state is ShopListStateResult) {
          _hideLoaderIfVisible();
          CallDialogue.showResult(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        if (state is ShopListStateLoading || state is ShopListStateInitial) {
          return AppSize.noGap;
        } else if (state is ShopListStateFetch) {
          return RefreshIndicator(
            color: AppColor.colorPrimary,
            onRefresh: () async {
              final bloc = context.read<ShopListBloc>();
              final loaded = bloc.stream.firstWhere(
                (next) =>
                    next is ShopListStateFetch || next is ShopListStateResult,
              );
              bloc.add(ShopListEventFetch(query: _searchController.text));
              await loaded;
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSize.paddingAll25,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CustomFieldPrimary(
                    controller: _searchController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    label: AppText.search,
                    isRequired: false,
                    prefixWidget: const Icon(Icons.search),
                    onChanged: (query) => context.read<ShopListBloc>().add(
                      ShopListEventFetch(query: query, debounce: true),
                    ),
                  );
                }
                if (state.shopList.isEmpty) {
                  return state.search.isNotEmpty
                      ? Padding(
                          padding: AppSize.paddingAll25,
                          child: Center(
                            child: Text(
                              AppText.noResultsFound,
                              style: AppText.style.bodySmall,
                            ),
                          ),
                        )
                      : const CustomNotFound();
                }
                if (index == state.shopList.length + 1) {
                  return CustomPaginationFooter(
                    hasMore: state.hasMore,
                    isLoadingMore: state.isLoadingMore,
                    textLoadMoreError: state.loadMoreError,
                    onLoadMore: () => context.read<ShopListBloc>().add(
                      ShopListEventLoadMore(),
                    ),
                  );
                }
                final shop = state.shopList[index - 1];
                return _shopListItemCard(shop: shop, context: context);
              },
              separatorBuilder: (BuildContext context, int index) {
                return AppSize.gapH20;
              },
              itemCount: state.shopList.isEmpty ? 2 : state.shopList.length + 2,
            ),
          );
        } else {
          return CustomNotFound();
        }
      },
    );
  }

  Widget _shopListItemCard({
    required ModelShopList shop,
    required BuildContext context,
  }) {
    return CustomCardWithAction(
      onTap: () {
        context.push(AppRouter.screenShopDetailsUser, extra: shop.id);
      },
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
    );
  }
}
