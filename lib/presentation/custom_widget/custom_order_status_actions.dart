/*
Created by Neloy on 21 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_card.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_dialogue.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';

import '../../utilities/app_constant.dart';
import '../../utilities/app_text.dart';

class OrderStatusActions extends StatelessWidget {
  final String status;
  final bool isShop;
  final bool isUpdating;
  final ValueChanged<OrderStatusAction> onUpdate;

  const OrderStatusActions({
    super.key,
    required this.status,
    required this.isShop,
    required this.isUpdating,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final actions = _availableActions();
    if (actions.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomCard(
            colorBorder: AppColor.colorPrimary,
            child: Column(
              children: [
                Text(AppText.nextStep, style: AppText.style.titleMedium),
                AppSize.gapH10,
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: actions
                      .map(
                        (action) => _ActionButton(
                          action: action,
                          isUpdating: isUpdating,
                          onPressed: () => _confirmAndUpdate(context, action),
                        ),
                      )
                      .toList(),
                ),
                if (isUpdating) ...[
                  AppSize.gapH10,
                  const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: AppColor.colorPrimary,
                      strokeWidth: 0.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        AppSize.gapH20,
      ],
    );
  }

  List<OrderStatusAction> _availableActions() {
    if (isShop) {
      return switch (status) {
        AppConstant.pending => [
          OrderStatusAction.accepted,
          OrderStatusAction.rejected,
        ],
        AppConstant.accepted => [OrderStatusAction.ready],
        AppConstant.ready => [OrderStatusAction.handoverRequest],
        _ => const [],
      };
    }
    return status == AppConstant.handoverRequest
        ? [OrderStatusAction.received]
        : const [];
  }

  Future<void> _confirmAndUpdate(
    BuildContext context,
    OrderStatusAction action,
  ) async {
    if (isUpdating) return;
    final confirmation = switch (action) {
      OrderStatusAction.rejected =>
      AppText.orderRejectQuestion,
      OrderStatusAction.handoverRequest =>
      AppText.handoverInstruction,
      OrderStatusAction.received =>
      AppText.receivedOrderQuestion,
      _ => null,
    };

    if (confirmation != null) {
      CallDialogue.showQuestion(
        context: context,
        message: confirmation,
        onYes: () {
          onUpdate(action);
          context.pop();
        },
      );
    }else {
      onUpdate(action);
    }


  }
}

class _ActionButton extends StatelessWidget {
  final OrderStatusAction action;
  final bool isUpdating;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.action,
    required this.isUpdating,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final (label, icon) = switch (action) {
      OrderStatusAction.accepted => (
        AppText.acceptOrder,
        Icons.check_circle_outline,
      ),
      OrderStatusAction.rejected => (
        AppText.rejectOrder,
        Icons.cancel_outlined,
      ),
      OrderStatusAction.ready => (
        AppText.markAsReady,
        Icons.local_laundry_service,
      ),
      OrderStatusAction.handoverRequest => (
        AppText.requestHandover,
        Icons.delivery_dining,
      ),
      OrderStatusAction.received => (AppText.confirmReceived, Icons.task_alt),
    };

    if (action == OrderStatusAction.rejected) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: isUpdating ? null : onPressed,
          icon: Icon(icon),
          label: Text(label, style: AppText.style.bodySmall),
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
            shape: RoundedRectangleBorder(
              borderRadius: AppSize.borderRadiusAll10,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: isUpdating ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColor.colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: AppSize.borderRadiusAll10,
          ),
        ),
        icon: Icon(icon),
        label: Text(
          label,
          style: AppText.style.bodySmall!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
