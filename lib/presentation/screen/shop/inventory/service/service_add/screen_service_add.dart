/* 
Created by Neloy on 12 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../../../../../utilities/app_size.dart';
import '../../../../../../utilities/app_text.dart';
import '../../../../../../utilities/app_text_formatter.dart';
import '../../../../../../utilities/app_validator.dart';
import '../../../../../custom_widget/custom_button.dart';
import '../../../../../custom_widget/custom_text_field.dart';

class ScreenServiceAdd extends StatefulWidget {
  const ScreenServiceAdd({super.key});

  @override
  State<ScreenServiceAdd> createState() => _ScreenServiceAddState();
}

class _ScreenServiceAddState extends State<ScreenServiceAdd> {
  final _serviceAddKey = GlobalKey<FormState>();

  final TextEditingController controllerServiceName = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();

  @override
  void dispose() {
    controllerServiceName.dispose();
    controllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.addNewService)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSize.paddingAll25,
          child: Form(
            key: _serviceAddKey,
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

                CustomButton(
                  onPressed: () {
                    if (_serviceAddKey.currentState!.validate()) {}
                  },
                  buttonText: AppText.add,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
