/* 
Created by Neloy on 18 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/client/client_constant.dart';
import '../../../../../data/repository/repository_authentication.dart';
import '../../../../../data/request/request_change_phone.dart';
import '../../../../../data/use_case/authentication/use_case_otp_request.dart';

part 'change_phone_event.dart';

part 'change_phone_state.dart';

class ChangePhoneBloc extends Bloc<ChangePhoneEvent, ChangePhoneState> {
  final IRepositoryAuthentication repositoryAuthentication;

  ChangePhoneBloc({required this.repositoryAuthentication})
    : super(ChangePhoneStateInitial()) {
    on<ChangePhoneEventProceed>(_onChangePhoneEventProceed);
  }

  Future<void> _onChangePhoneEventProceed(
    ChangePhoneEventProceed event,
    Emitter<ChangePhoneState> emit,
  ) async {
    emit(ChangePhoneStateLoading());
    try {
      RequestChangePhone requestBody = RequestChangePhone(
        oldPhone: event.oldPhone,
        newPhone: event.newPhone,
      );

      UseCaseOTPRequest useCaseOTPRequest = await repositoryAuthentication
          .changePhone(requestBody: requestBody);
      if (useCaseOTPRequest.isNavigateOTP) {
        emit(
          ChangePhoneStateNavigateOTP(
            otpRequestId: useCaseOTPRequest.otpRequestId!,
            recordId: useCaseOTPRequest.recordId!,
            message: useCaseOTPRequest.message!,
          ),
        );
      } else {
        emit(ChangePhoneStateResult(message: useCaseOTPRequest.message!));
      }
    } catch (e) {
      emit(ChangePhoneStateResult(message: ClientConstant.serverError));
    }
  }
}
