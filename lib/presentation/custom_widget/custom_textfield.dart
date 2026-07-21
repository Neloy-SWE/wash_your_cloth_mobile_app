/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/app_color.dart';
import '../../utilities/app_size.dart';
import '../../utilities/app_text.dart';
import 'custom_title.dart';

class CustomFieldPrimary extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  final String? title;
  final bool isSecure;
  final bool isReadOnly;
  final bool isArea;

  // final String hint;
  final String label;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;

  const CustomFieldPrimary({
    super.key,
    this.validator,
    required this.controller,
    required this.textInputType,
    required this.textInputAction,
    this.onChanged,
    // this.hint = "",
    this.label = "",
    this.onFieldSubmitted,
    this.prefixWidget,
    this.suffixWidget,
    this.title,
    this.isSecure = false,
    this.isRequired = true,
    this.inputFormatters,
    this.isReadOnly = false,
    this.onTap,
    this.isArea = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        title != null
            ? CustomTitlePrimary(title: title!, isRequired: isRequired)
            : AppSize.noGap,

        TextFormField(
          style: AppText.style.bodyMedium,
          validator: validator,
          controller: controller,
          keyboardType: textInputType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: inputFormatters,
          obscureText: isSecure,
          minLines: isArea ? 3 : null,
          maxLines: isArea ? 5 : 1,
          readOnly: isReadOnly,
          onTap: onTap,
          decoration: InputDecoration(
            errorStyle: AppText.style.bodySmall,
            prefixIcon: prefixWidget,
            suffixIcon: suffixWidget,
            contentPadding: AppSize.paddingAll10,
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.black),
              borderRadius: AppSize.borderRadiusAll8,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppColor.colorPrimary,
              ),
              borderRadius: AppSize.borderRadiusAll8,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppColor.colorDanger,
              ),
              borderRadius: AppSize.borderRadiusAll8,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.black),
              borderRadius: AppSize.borderRadiusAll8,
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.black54),
              borderRadius: AppSize.borderRadiusAll8,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppColor.colorDanger,
              ),
              borderRadius: AppSize.borderRadiusAll8,
            ),

            // hintText: hint,
            labelText: label,

            // hintStyle: AppText.style.bodySmall!.copyWith(
            //   color: AppColor.colorTextHint,
            //   fontSize: 15,
            // ),
            labelStyle: AppText.style.bodyMedium!.copyWith(
              color: AppColor.colorHint,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomFieldOTP extends StatelessWidget {
  final List<TextEditingController> otpController;
  final List<FocusNode> otpFocusNode;
  final bool isError;

  const CustomFieldOTP({
    super.key,
    required this.otpController,
    required this.otpFocusNode,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          otpController.length,
              (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SizedBox(
              height: 62,
              width: 55,
              child: TextField(
                controller: otpController[index],
                focusNode: otpFocusNode[index],
                textAlign: TextAlign.center,
                cursorColor: AppColor.colorPrimary,
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: isError ? AppColor.colorDanger : AppColor.colorPrimary,
                ),
                cursorWidth: 0.5,
                cursorHeight: 25,
                onTap: () {
                  final text = otpController[index].text;
                  otpController[index].selection = TextSelection.fromPosition(
                    TextPosition(offset: text.length),
                  );
                },
                onChanged: (value) {
                  if (value.length == 1 && index < otpController.length - 1) {
                    FocusScope.of(
                      context,
                    ).requestFocus(otpFocusNode[index + 1]);
                    Future.delayed(Duration.zero, () {
                      final text = otpController[index + 1].text;
                      otpController[index + 1].selection =
                          TextSelection.fromPosition(
                            TextPosition(offset: text.length),
                          );
                    });
                  } else if (value.isEmpty && index > 0) {
                    FocusScope.of(
                      context,
                    ).requestFocus(otpFocusNode[index - 1]);

                    Future.delayed(Duration.zero, () {
                      final text = otpController[index - 1].text;
                      otpController[index - 1].selection =
                          TextSelection.fromPosition(
                            TextPosition(offset: text.length),
                          );
                    });
                  }
                },
                inputFormatters: [LengthLimitingTextInputFormatter(1)],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  hintText: "0",
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.black12),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: isError
                          ? AppColor.colorDanger
                          : AppColor.colorPrimary,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: isError
                          ? AppColor.colorDanger
                          : AppColor.colorPrimary,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColor.colorDanger,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: isError
                          ? AppColor.colorDanger
                          : AppColor.colorPrimary,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black54,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColor.colorDanger,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}