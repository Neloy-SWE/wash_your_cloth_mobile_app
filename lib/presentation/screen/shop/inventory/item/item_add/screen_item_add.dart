/* 
Created by Neloy on 14 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../utilities/app_size.dart';
import '../../../../../../utilities/app_text.dart';
import '../../../../../../utilities/app_text_formatter.dart';
import '../../../../../../utilities/app_validator.dart';
import '../../../../../custom_widget/custom_button.dart';
import '../../../../../custom_widget/custom_dialogue.dart';
import '../../../../../custom_widget/custom_snack_bar.dart';
import '../../../../../custom_widget/custom_text_field.dart';
import 'bloc/item_add_bloc.dart';

class ScreenItemAdd extends StatefulWidget {
  const ScreenItemAdd({super.key});

  @override
  State<ScreenItemAdd> createState() => _ScreenItemAddState();
}

class _ScreenItemAddState extends State<ScreenItemAdd> {
  final _itemAddKey = GlobalKey<FormState>();

  final TextEditingController controllerItemName = TextEditingController();

  @override
  void dispose() {
    controllerItemName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.addNewItem)),
      body: SafeArea(
        child: BlocConsumer<ItemAddBloc, ItemAddState>(
          listener: (context, state) {
            if (state is ItemAddStateLoading) {
              CallDialogue.showLoader(context);
            } else if (state is ItemAddStateResult) {
              CallDialogue.hideLoader(context);
              if (state.isNavigate) {
                CustomSnackBar.primary(
                  context: context,
                  contentText: state.message,
                );
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted && context.canPop()) {
                    context.pop(true);
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
                key: _itemAddKey,
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

                    CustomButton(
                      onPressed: () {
                        if (_itemAddKey.currentState!.validate()) {
                          context.read<ItemAddBloc>().add(
                            ItemAddEventSubmit(
                              itemName: controllerItemName.text.trim(),
                            ),
                          );
                        }
                      },
                      buttonText: AppText.add,
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
