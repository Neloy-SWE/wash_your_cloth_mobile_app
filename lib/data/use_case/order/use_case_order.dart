/* 
Created by Neloy on 18 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/model/model_error.dart';

import '../../client/client_constant.dart';

class UseCaseOrder<T> {
  bool isSuccess;
  T? data;
  String? message;

  UseCaseOrder({required this.isSuccess, this.data, this.message});

  factory UseCaseOrder.serverError({String? customMessage}) {
    return UseCaseOrder(
      isSuccess: false,
      message: customMessage ?? ClientConstant.serverError,
    );
  }

  factory UseCaseOrder.fromModelError(ModelError modelError) {
    final hasErrorText = modelError.error?.isNotEmpty == true;
    return UseCaseOrder(
      isSuccess: false,
      message: hasErrorText ? modelError.error!.first : ClientConstant.serverError,
    );
  }
}
