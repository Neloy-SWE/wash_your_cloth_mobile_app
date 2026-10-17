/* 
Created by Neloy on 14 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../utilities/app_color.dart';
import '../../../../../../utilities/app_constant.dart';
import '../../../../../../utilities/app_size.dart';
import '../../../../../../utilities/app_text.dart';
import '../../../../../../utilities/app_text_formatter.dart';
import '../../../../../../utilities/app_validator.dart';
import '../../../../../custom_widget/custom_button.dart';
import '../../../../../custom_widget/custom_dialogue.dart';
import '../../../../../custom_widget/custom_snack_bar.dart';
import '../../../../../custom_widget/custom_text_field.dart';
import 'bloc/item_update_bloc.dart';

class ScreenItemUpdate extends StatefulWidget {
  final String itemName;
  final String itemId;

  const ScreenItemUpdate({
    super.key,
    required this.itemName,
    required this.itemId,
  });

  @override
  State<ScreenItemUpdate> createState() => _ScreenItemUpdateState();
}

class _ScreenItemUpdateState extends State<ScreenItemUpdate> {
  final _itemEditKey = GlobalKey<FormState>();

  final TextEditingController controllerItemName = TextEditingController();

  final ValueNotifier<bool> isFormChanged = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    controllerItemName.text = widget.itemName;

    controllerItemName.addListener(_checkIsChanged);
  }

  void _checkIsChanged() {
    final hasChanged = controllerItemName.text.trim() != widget.itemName.trim();

    if (isFormChanged.value != hasChanged) {
      isFormChanged.value = hasChanged;
    }
  }

  @override
  void dispose() {
    controllerItemName.removeListener(_checkIsChanged);
    controllerItemName.dispose();
    isFormChanged.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.updateItem)),
      body: SafeArea(
        child: BlocConsumer<ItemUpdateBloc, ItemUpdateState>(
          listener: (context, state) {
            if (state is ItemUpdateStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is ItemUpdateStateResult) {
              CallDialogue.hideLoader(context);
              if (state.isNavigate) {
                CustomSnackBar.primary(
                  context: context,
                  contentText: state.message,
                );
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted && context.canPop()) {
                    context.pop({
                      AppConstant.itemName: controllerItemName.text.trim(),
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
                key: _itemEditKey,
                child: Column(
                  children: [
                    CustomFieldPrimary(
                      controller: controllerItemName,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [FirstLetterUpperCaseFormatter()],
                      title: AppText.itemName,
                      isRequired: true,
                      label: AppText.itemNameHint,
                      validator: (value) {
                        if (!AppValidator.isName(value)) {
                          return AppValidator.validatorItemName;
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
                              if (_itemEditKey.currentState!.validate()) {
                                context.read<ItemUpdateBloc>().add(
                                  ItemUpdateEventSubmit(
                                    itemName: controllerItemName.text.trim(),
                                    itemId: widget.itemId,
                                  ),
                                );
                              }
                            } else {
                              CustomSnackBar.primary(
                                context: context,
                                contentText: AppValidator.validatorItemUpdate,
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
