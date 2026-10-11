/* 
Created by Neloy on 11 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_validator.dart';

import '../../../../../../utilities/app_color.dart';
import '../../../../../../utilities/app_constant.dart';
import '../../../../../../utilities/app_size.dart';
import '../../../../../../utilities/app_text.dart';
import '../../../../../../utilities/app_text_formatter.dart';
import '../../../../../custom_widget/custom_button.dart';
import '../../../../../custom_widget/custom_dialogue.dart';
import '../../../../../custom_widget/custom_snack_bar.dart';
import '../../../../../custom_widget/custom_text_field.dart';
import 'bloc/service_update_bloc.dart';

class ScreenServiceUpdate extends StatefulWidget {
  final String serviceName;
  final String description;
  final String serviceId;

  const ScreenServiceUpdate({
    super.key,
    required this.serviceName,
    required this.description,
    required this.serviceId,
  });

  @override
  State<ScreenServiceUpdate> createState() => _ScreenServiceUpdateState();
}

class _ScreenServiceUpdateState extends State<ScreenServiceUpdate> {
  final _serviceEditKey = GlobalKey<FormState>();

  final TextEditingController controllerServiceName = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();

  final ValueNotifier<bool> isFormChanged = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    controllerServiceName.text = widget.serviceName;
    controllerDescription.text = widget.description;

    controllerServiceName.addListener(_checkIsChanged);
    controllerDescription.addListener(_checkIsChanged);
  }

  void _checkIsChanged() {
    final hasChanged =
        controllerServiceName.text.trim() != widget.serviceName.trim() ||
        controllerDescription.text.trim() != widget.description.trim();

    if (isFormChanged.value != hasChanged) {
      isFormChanged.value = hasChanged;
    }
  }

  @override
  void dispose() {
    controllerServiceName.removeListener(_checkIsChanged);
    controllerDescription.removeListener(_checkIsChanged);
    controllerServiceName.dispose();
    controllerDescription.dispose();
    isFormChanged.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.updateService)),
      body: SafeArea(
        child: BlocConsumer<ServiceUpdateBloc, ServiceUpdateState>(
          listener: (context, state) {
            if (state is ServiceUpdateStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is ServiceUpdateStateResult) {
              CallDialogue.hideLoader(context);
              if (state.isNavigate) {
                CustomSnackBar.primary(
                  context: context,
                  contentText: state.message,
                );
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted && context.canPop()) {
                    context.pop({
                      AppConstant.serviceName: controllerServiceName.text
                          .trim(),
                      AppConstant.description: controllerDescription.text
                          .trim(),
                    });
                  }
                });
              } else {
                CallDialogue.showResult(
                  context: context,
                  message: state.message,
                  onOk: () => CallDialogue.hideLoader(context),
                );
              }
            }
          },

          builder: (context, state) {
            return SingleChildScrollView(
              padding: AppSize.paddingAll25,
              child: Form(
                key: _serviceEditKey,
                child: Column(
                  children: [
                    CustomFieldPrimary(
                      controller: controllerServiceName,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [FirstLetterUpperCaseFormatter()],
                      title: AppText.serviceName,
                      isRequired: true,
                      label: AppText.serviceNameHint,
                      validator: (value) {
                        if (!AppValidator.isName(value)) {
                          return AppValidator.validatorServiceName;
                        }
                        return null;
                      },
                    ),
                    AppSize.gapH15,

                    CustomFieldPrimary(
                      controller: controllerDescription,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      title: AppText.description,
                      isRequired: true,
                      isArea: true,
                      label: AppText.descriptionHint,
                      validator: (value) {
                        if (!AppValidator.isValidDescription(value)) {
                          return AppValidator.validatorDescription;
                        }
                        return null;
                      },
                    ),
                    AppSize.gapH80,

                    ValueListenableBuilder<bool>(
                      valueListenable: isFormChanged,
                      builder: (context, isChanged, child) {
                        return CustomButton(
                          onPressed: () {
                            if (isChanged) {
                              if (_serviceEditKey.currentState!.validate()) {
                                context.read<ServiceUpdateBloc>().add(
                                  ServiceUpdateEventSubmit(
                                    serviceName: controllerServiceName.text
                                        .trim(),
                                    description: controllerDescription.text
                                        .trim(),
                                    serviceId: widget.serviceId,
                                  ),
                                );
                              }
                            } else {
                              CustomSnackBar.primary(
                                context: context,
                                contentText:
                                    AppValidator.validatorServiceUpdate,
                                backgroundColor: AppColor.colorDanger,
                              );
                            }
                          },
                          buttonText: AppText.update,
                          colorButton: isChanged
                              ? AppColor.colorPrimary
                              : AppColor.colorBorderStatusPending,
                          colorBorder: isChanged
                              ? AppColor.colorPrimary
                              : AppColor.colorBorderStatusPending,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
