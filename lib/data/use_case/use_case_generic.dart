/* 
Created by Neloy on 18 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/model/model_error.dart';

import '../client/client_constant.dart';

class UseCaseGeneric<T> {
  bool isSuccess;
  T? data;
  String? message;

  UseCaseGeneric({required this.isSuccess, this.data, this.message});

  factory UseCaseGeneric.serverError({String? customMessage}) {
    return UseCaseGeneric(
      isSuccess: false,
      message: customMessage ?? ClientConstant.serverError,
    );
  }

  factory UseCaseGeneric.fromModelError(ModelError modelError) {
    final hasErrorText = modelError.error?.isNotEmpty == true;
    return UseCaseGeneric(
      isSuccess: false,
      message: hasErrorText ? modelError.error!.first : ClientConstant.serverError,
    );
  }
}
