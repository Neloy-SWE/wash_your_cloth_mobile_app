/* 
Created by Neloy on 14 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_item_list.dart';

import '../../../../../../router/app_router.dart';
import '../../../../../../utilities/app_color.dart';
import '../../../../../../utilities/app_constant.dart';
import '../../../../../../utilities/app_size.dart';
import '../../../../../../utilities/app_text.dart';
import '../../../../../../utilities/app_validator.dart';
import '../../../../../custom_widget/custom_card.dart';
import '../../../../../custom_widget/custom_dialogue.dart';
import '../../../../../custom_widget/custom_list_header.dart';
import '../../../../../custom_widget/custom_not_found.dart';
import '../../../../../custom_widget/custom_snack_bar.dart';
import 'bloc/item_list_bloc.dart';

class ScreenItemList extends StatelessWidget {
  const ScreenItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.itemList)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSize.paddingAll25,
          child: Column(
            children: [
              CustomListHeader(
                textListName: AppText.itemList,
                onTap: () => navigateToAddItem(context: context),
                textAddNewListName: AppText.addNewItem,
              ),
              AppSize.gapH20,

              BlocConsumer<ItemListBloc, ItemListState>(
                listener: (context, state) {
                  if (state is ItemListStateLoading) {
                    CallDialogue.showLoader(context);
                  } else if (state is ItemListStateFetch) {
                    if (!state.isActivating && !state.isUpdating) {
                      CallDialogue.hideLoader(context);
                    }
                  } else if (state is ItemListStateError) {
                    CallDialogue.hideLoader(context);
                    CallDialogue.showResult(
                      context: context,
                      message: state.message,
                      onOk: () => CallDialogue.hideLoader(context),
                    );
                  } else if (state is ItemListStateActionResult) {
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
                  if (state is ItemListStateFetch) {
                    if (state.itemList.isEmpty) {
                      return const CustomNotFound();
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.itemList.length,
                      separatorBuilder: (context, index) => AppSize.gapH20,
                      itemBuilder: (context, index) {
                        final item = state.itemList[index];
                        return CustomCard(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.itemName,
                                  style: AppText.style.titleMedium,
                                ),
                              ),
                              Row(
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Transform.scale(
                                        scale: 0.5,
                                        child: CupertinoSwitch(
                                          value: item.isActive,
                                          activeTrackColor:
                                              AppColor.colorPrimary,
                                          onChanged: state.isActivating
                                              ? null // Disable during pending request
                                              : (value) {
                                                  _handleItemActivation(
                                                    context: context,
                                                    itemId: item.id,
                                                  );
                                                },
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Text(
                                          item.isActive
                                              ? AppText.active
                                              : AppText.inactive,
                                          style: AppText.style.bodyLarge!
                                              .copyWith(fontSize: 8),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () => navigateToUpdateItem(
                                      context: context,
                                      item: item,
                                    ),
                                    icon: Icon(Icons.edit, size: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is ItemListStateLoading ||
                      state is ItemListStateInitial) {
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
    );
  }

  void _handleItemActivation({
    required BuildContext context,
    required String itemId,
  }) {
    CallDialogue.showResult(
      context: context,
      message: AppText.itemActivationAlertMessage,
      onOk: () {
        CallDialogue.hideLoader(context); // Close confirmation alert first
        context.read<ItemListBloc>().add(
          ItemListEventActivation(itemId: itemId),
        );
        CallDialogue.showLoader(context);
      },
    );
  }

  Future<void> navigateToUpdateItem({
    required BuildContext context,
    required ModelItemList item,
  }) async {
    try {
      final Map? result = await context.push(
        AppRouter.screenItemUpdate,
        extra: {
          AppConstant.itemName: item.itemName,
          AppConstant.itemId: item.id,
        },
      );

      if (result != null && context.mounted) {
        context.read<ItemListBloc>().add(
          ItemListEventUpdate(
            itemName: result[AppConstant.itemName],
            itemId: item.id,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackBar.primary(
          context: context,
          contentText: AppValidator.validatorItemUpdateFail,
        );
      }
    }
  }

  Future<void> navigateToAddItem({required BuildContext context}) async {
    try {
      final bool? result = await context.push(AppRouter.screenItemAdd);

      if (result != null && result && context.mounted) {
        context.read<ItemListBloc>().add(ItemListEventFetch());
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackBar.primary(
          context: context,
          contentText: AppValidator.validatorItemAddFail,
        );
      }
    }
  }
}
