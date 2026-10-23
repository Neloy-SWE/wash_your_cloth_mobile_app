/*
Created by Neloy on 02 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_button.dart';
import 'package:wash_your_cloth_mobile_app/presentation/bloc_global/global_bloc.dart';
import 'package:wash_your_cloth_mobile_app/router/app_router.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_constant.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';

class CustomDialogue extends StatelessWidget {
  final DialogueType dialogueType;
  final String message;
  final void Function()? onYesPressed;
  final void Function()? onNoPressed;
  final void Function()? onOkPressed;

  const CustomDialogue({
    super.key,
    required this.dialogueType,
    required this.message,
    this.onYesPressed,
    this.onNoPressed,
    this.onOkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (dialogueType == DialogueType.loader) _loader(),
            if (dialogueType == DialogueType.question) _question(context),
            if (dialogueType == DialogueType.result) _result(context),
          ],
        ),
      ),
    );
  }

  Widget _loader() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _question(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                colorBorder: AppColor.colorPrimary,
                colorButton: Colors.white,
                colorText: AppColor.colorPrimary,
                onPressed: onYesPressed ?? () => Navigator.of(context).pop(),
                buttonText: AppText.yes,
              ),
            ),
            AppSize.gapW10,
            Expanded(
              child: CustomButton(
                onPressed: onNoPressed ?? () => Navigator.of(context).pop(),
                buttonText: AppText.no,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _result(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: AppText.style.titleSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            onPressed: onOkPressed ?? () => Navigator.of(context).pop(),
            buttonText: AppText.okay,
          ),
        ),
      ],
    );
  }
}

class CallDialogue {
  static void showLoader(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) =>
              CustomDialogue(dialogueType: DialogueType.loader, message: ''),
        );
      }
    });
  }

  static void showQuestion({
    required BuildContext context,
    required String message,
    required void Function() onYes,
    void Function()? onNo,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => CustomDialogue(
            dialogueType: DialogueType.question,
            message: message,
            onYesPressed: () {
              onYes();
            },
            onNoPressed: onNo,
          ),
        );
      }
    });
  }

  static void showResult({
    required BuildContext context,
    required String message,
    void Function()? onOk,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (dialogContext) => CustomDialogue(
            dialogueType: DialogueType.result,
            message: message,
            onOkPressed: () {
              if (onOk == null) {
                Navigator.of(dialogContext, rootNavigator: true).pop();
              } else {
                onOk();
              }
              final globalState = context.read<GlobalBloc>().state;
              if (globalState.sessionExpired &&
                  globalState.deferRedirectUntilResultDismissed) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    AppRouter.door.go(AppRouter.screenRole);
                  }
                });
              }
            },
          ),
        );
      }
    });
  }

  static void hideLoader(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        final navigator = Navigator.of(context, rootNavigator: true);
        if (navigator.canPop()) {
          navigator.pop();
        }
      }
    });
  }
}
