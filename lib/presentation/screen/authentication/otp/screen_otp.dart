/* 
Created by Neloy on 02 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/authentication/otp/bloc/otp_bloc.dart';
import 'package:wash_your_cloth_mobile_app/router/app_router.dart';

import '../../../../utilities/app_color.dart';
import '../../../../utilities/app_size.dart';
import '../../../../utilities/app_text.dart';
import '../../../../utilities/app_validator.dart';
import '../../../bloc_global/global_bloc.dart';
import '../../../custom_widget/custom_button.dart';
import '../../../custom_widget/custom_dialogue.dart';
import '../../../custom_widget/custom_snack_bar.dart';
import '../../../custom_widget/custom_textfield.dart';

class ScreenOTP extends StatefulWidget {
  const ScreenOTP({super.key});

  @override
  State<ScreenOTP> createState() => _ScreenOTPState();
}

class _ScreenOTPState extends State<ScreenOTP> {
  static const int otpLength = 4;

  late List<TextEditingController> otpController = List.generate(
    otpLength,
    (index) => TextEditingController(),
  );
  late List<FocusNode> otpFocusNode = List.generate(
    otpLength,
    (index) => FocusNode(),
  );
  String otpCode = "";
  bool isError = false;

  // int otpSecondsRemaining = 0;
  // bool otpEnableResend = false;

  // @override
  // void initState() {
  //   _otpResetCount();
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (otpSecondsRemaining != 0) {
  //       if (mounted) {
  //         setState(() {
  //           otpSecondsRemaining--;
  //         });
  //       }
  //     } else {
  //       if (mounted) {
  //         setState(() {
  //           otpEnableResend = true;
  //         });
  //       }
  //     }
  //   });
  //   super.initState();
  // }

  @override
  void dispose() {
    for (int i = 0; i < otpLength; i++) {
      otpController[i].dispose();
      otpFocusNode[i].dispose();
    }
    super.dispose();
  }

  // void _otpResetCount() {
  //   otpSecondsRemaining = 10;
  //   otpEnableResend = false;
  // }

  @override
  Widget build(BuildContext context) {
    var otpRequestId = context.read<GlobalBloc>().state.otpRequestId;
    var recordId = context.read<GlobalBloc>().state.recordId;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocConsumer<OTPBloc, OTPState>(
          listener: (context, state) {
            if (state is OTPStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is OTPStateVerify) {
              CallDialogue.hideLoader(context);
              CustomSnackBar.primary(
                context: context,
                contentText: state.message,
              );
              context.go(AppRouter.screenLogin);
            } else if (state is OTPStateResult) {
              CallDialogue.hideLoader(context);
              CallDialogue.showResult(
                context: context,
                message: state.message,
                onOk: () {
                  CallDialogue.hideLoader(context);
                },
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: AppSize.paddingAll25,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 15,
                        ),
                        alignment: .center,
                        decoration: BoxDecoration(
                          borderRadius: AppSize.borderRadiusAll10,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.colorPrimaryTextSelection,
                              blurRadius: 5,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: .center,
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              AppText.verifyOtp,
                              textAlign: .center,
                              style: AppText.style.titleLarge!.copyWith(
                                color: AppColor.colorPrimary,
                              ),
                            ),
                            AppSize.gapH05,
                            Text(
                              AppText.otpInstruction,
                              textAlign: .center,
                              style: AppText.style.bodyMedium,
                            ),
                            AppSize.gapH20,
                            CustomFieldOTP(
                              otpController: otpController,
                              otpFocusNode: otpFocusNode,
                              isError: isError,
                            ),
                            AppSize.gapH10,
                            CustomButton(
                              onPressed: () => _confirmOTP(
                                otpRequestId: otpRequestId!,
                                recordId: recordId!,
                              ),
                              buttonText: AppText.verify,
                            ),
                          ],
                        ),
                      ),
                      AppSize.gapH35,
                      // Row(
                      //   mainAxisAlignment: .center,
                      //   crossAxisAlignment: .center,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         if (otpEnableResend) {
                      //           _otpResetCount();
                      //         }
                      //       },
                      //       child: Container(
                      //         height: 35,
                      //         width: 35,
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           shape: BoxShape.circle,
                      //           border: Border.all(
                      //             color: AppColor.colorPrimaryTextSelection,
                      //             width: 2,
                      //           ),
                      //         ),
                      //         child: Icon(
                      //           Icons.refresh,
                      //           color: otpEnableResend
                      //               ? AppColor.colorPrimary
                      //               : AppColor.colorPrimaryTextSelection,
                      //         ),
                      //       ),
                      //     ),
                      //     AppSize.gapW10,
                      //     Text(
                      //       otpEnableResend
                      //           ? AppText.otpExpired
                      //           : "${AppText.expireIn} ${(otpSecondsRemaining ~/ 60).toString().padLeft(2, '0')}:${(otpSecondsRemaining % 60).toString().padLeft(2, '0')}",
                      //       style: AppText.style.titleSmall!.copyWith(
                      //         color: otpEnableResend
                      //             ? AppColor.colorDanger
                      //             : Colors.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _confirmOTP({required String otpRequestId, required String recordId}) {
    otpCode = "";
    isError = false;
    for (int i = 0; i < otpController.length; i++) {
      otpCode = otpCode + otpController[i].text;
    }

    if (otpCode.length == otpController.length) {
      FocusManager.instance.primaryFocus?.unfocus();
      context.read<OTPBloc>().add(
        OTPEventVerify(
          recordId: recordId,
          otpRequestId: otpRequestId,
          otpCode: otpCode,
        ),
      );
    } else {
      CustomSnackBar.primary(
        context: context,
        contentText: AppValidator.validatorOTP,
        backgroundColor: AppColor.colorDanger,
      );
      isError = true;
    }
  }
}
