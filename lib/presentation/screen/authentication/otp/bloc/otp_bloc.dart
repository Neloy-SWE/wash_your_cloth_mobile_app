/* 
Created by Neloy on 11 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/usecase/use_case_otp_verify.dart';

import '../../../../../data/client/client_constant.dart';
import '../../../../../data/repository/repository_authentication.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState> {
  final IRepositoryAuthentication repositoryAuthentication;

  OTPBloc({required this.repositoryAuthentication}) : super(OTPStateInitial()) {
    on<OTPEventVerify>(_onOTPEventVerify);
  }

  Future<void> _onOTPEventVerify(
    OTPEventVerify event,
    Emitter<OTPState> emit,
  ) async {
    emit(OTPStateLoading());
    try {
      OTPVerifyData otpVerifyData = OTPVerifyData(
        otpRequestId: event.otpRequestId,
        recordId: event.recordId,
        otpCode: event.otpCode,
      );

      UseCaseOtpVerify useCaseOtpVerify = await repositoryAuthentication
          .otpVerify(otpVerifyData: otpVerifyData);

      if (useCaseOtpVerify.isVerify) {
        emit(OTPStateVerify(message: useCaseOtpVerify.message));
      } else {
        emit(OTPStateResult(message: useCaseOtpVerify.message));
      }
    } catch (e) {
      emit(OTPStateResult(message: ClientConstant.serverError));
    }
  }
}
