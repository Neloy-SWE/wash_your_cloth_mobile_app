/* 
Created by Neloy on 13 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/request/request_change_password.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/authentication/use_case_otp_request.dart';

import '../../../../../data/client/client_constant.dart';
import '../../../../../data/repository/repository_authentication.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final IRepositoryAuthentication repositoryAuthentication;

  ChangePasswordBloc({required this.repositoryAuthentication})
    : super(ChangePasswordStateInitial()) {
    on<ChangePasswordEventProceed>(_onChangePasswordEventProceed);
  }

  Future<void> _onChangePasswordEventProceed(
    ChangePasswordEventProceed event,
    Emitter<ChangePasswordState> emit,
  ) async {
    try {
      RequestChangePassword requestBody = RequestChangePassword(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      );

      UseCaseOTPRequest useCaseOTPRequest = await repositoryAuthentication
          .changePassword(requestBody: requestBody);
      if (useCaseOTPRequest.isNavigateOTP) {
        emit(
          ChangePasswordStateNavigateOTP(
            otpRequestId: useCaseOTPRequest.otpRequestId!,
            recordId: useCaseOTPRequest.recordId!,
            message: useCaseOTPRequest.message!,
          ),
        );
      } else {
        emit(ChangePasswordStateResult(message: useCaseOTPRequest.message!));
      }
    } catch (e) {
      emit(ChangePasswordStateResult(message: ClientConstant.serverError));
    }
  }
}
