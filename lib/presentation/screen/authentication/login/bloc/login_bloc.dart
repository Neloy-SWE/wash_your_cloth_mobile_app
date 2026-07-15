/* 
Created by Neloy on 30 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/authentication/use_case_login.dart';

import '../../../../../data/client/client_constant.dart';
import '../../../../../data/repository/repository_authentication.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IRepositoryAuthentication repositoryAuthentication;

  LoginBloc({required this.repositoryAuthentication})
    : super(LoginStateInitial()) {
    on<LoginEventLogin>(_onLogin);
  }

  Future<void> _onLogin(LoginEventLogin event, Emitter<LoginState> emit) async {
    emit(LoginStateLoading());

    try {
      UseCaseLogin useCaseLogin = await repositoryAuthentication.login(
        phone: event.phone,
        password: event.password,
        role: event.role,
      );

      if (useCaseLogin.isOTPRequired) {
        emit(
          LoginStateNavigateOTP(
            otpRequestId: useCaseLogin.otpRequestId!,
            recordId: useCaseLogin.recordId!, message: useCaseLogin.message!,
          ),
        );
      } else if (useCaseLogin.isLogin) {
        emit(LoginStateNavigateLogin());
      } else {
        emit(LoginStateResult(message: useCaseLogin.message!));
      }
    } catch (e) {
      emit(LoginStateResult(message: ClientConstant.serverError));
    }
  }
}
