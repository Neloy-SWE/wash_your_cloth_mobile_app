/*
Created by Neloy on 02 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_button.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_constant.dart';
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
              child: OutlinedButton(
                onPressed: onYesPressed ?? () => Navigator.of(context).pop(),
                child: const Text('Yes'),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: ElevatedButton(
                onPressed: onNoPressed ?? () => Navigator.of(context).pop(),
                child: const Text('No'),
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          CustomDialogue(dialogueType: DialogueType.loader, message: ''),
    );
  }

  static void showQuestion({
    required BuildContext context,
    required String message,
    required void Function() onYes,
    void Function()? onNo,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => CustomDialogue(
        dialogueType: DialogueType.question,
        message: message,
        onYesPressed: () {
          onYes();
        },
        onNoPressed: () {
          if (onNo != null) onNo();
        },
      ),
    );
  }

  static void showResult({
    required BuildContext context,
    required String message,
    void Function()? onOk,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => CustomDialogue(
        dialogueType: DialogueType.result,
        message: message,
        onOkPressed: () {
          if (onOk != null) onOk();
        },
      ),
    );
  }

  static void hideLoader(BuildContext context) {
    Navigator.of(context).pop();
  }
}
