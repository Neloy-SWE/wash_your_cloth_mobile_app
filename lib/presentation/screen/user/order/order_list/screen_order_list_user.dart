/* 
Created by Neloy on 13 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../router/app_router.dart';
import '../../../../../utilities/app_color.dart';
import '../../../../../utilities/app_size.dart';
import '../../../../../utilities/app_text.dart';
import '../../../../custom_widget/custom_dialogue.dart';
import '../../../../custom_widget/custom_not_found.dart';
import '../../../../custom_widget/custom_order_item_card.dart';
import '../../../../custom_widget/custom_pagination_footer.dart';
import '../../../../custom_widget/custom_text_field.dart';
import 'bloc/order_list_user_bloc.dart';

class ScreenOrderListUser extends StatefulWidget {
  const ScreenOrderListUser({super.key});

  @override
  State<ScreenOrderListUser> createState() => _ScreenOrderListUserState();
}

class _ScreenOrderListUserState extends State<ScreenOrderListUser> {
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
    return BlocConsumer<OrderListUserBloc, OrderListUserState>(
      listener: (context, state) {
        if (state is OrderListUserStateLoading) {
          _isLoaderVisible = true;
          CallDialogue.showLoader(context);
        } else if (state is OrderListUserStateFetch) {
          _hideLoaderIfVisible();
        } else if (state is OrderListUserStateResult) {
          _hideLoaderIfVisible();
          CallDialogue.showResult(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        if (state is OrderListUserStateLoading ||
            state is OrderListUserStateInitial) {
          return AppSize.noGap;
        } else if (state is OrderListUserStateFetch) {
          return RefreshIndicator(
            color: AppColor.colorPrimary,
            onRefresh: () async {
              final bloc = context.read<OrderListUserBloc>();
              final loaded = bloc.stream.firstWhere(
                (next) =>
                    next is OrderListUserStateFetch ||
                    next is OrderListUserStateResult,
              );
              bloc.add(OrderListUserEventFetch(query: _searchController.text));
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
                    onChanged: (query) => context.read<OrderListUserBloc>().add(
                      OrderListUserEventFetch(query: query, debounce: true),
                    ),
                  );
                }
                if (state.orderList.isEmpty) {
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
                if (index == state.orderList.length + 1) {
                  return CustomPaginationFooter(
                    hasMore: state.hasMore,
                    isLoadingMore: state.isLoadingMore,
                    textLoadMoreError: state.loadMoreError,
                    onLoadMore: () => context.read<OrderListUserBloc>().add(
                      OrderListUserEventLoadMore(),
                    ),
                  );
                }
                final order = state.orderList[index - 1];
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
              itemCount: state.orderList.isEmpty
                  ? 2
                  : state.orderList.length + 2,
            ),
          );
        } else {
          return CustomNotFound();
        }
      },
    );
  }
}
