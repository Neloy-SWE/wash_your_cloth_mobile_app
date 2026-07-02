/* 
Created by Neloy on 30 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wash_your_cloth_mobile_app/data/usecase/use_case_login.dart';

import '../../../../data/client/client_constant.dart';
import '../../../../data/repository/repository_authentication.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IRepositoryAuthentication repositoryAuthentication;

  AuthenticationBloc({required this.repositoryAuthentication})
    : super(AuthenticationStateInitial()) {
    on<AuthenticationEventLogin>(_onLogin);
  }

  Future<void> _onLogin(
    AuthenticationEventLogin event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationStateLoading());

    try {
      UseCaseLogin useCaseLogin = await repositoryAuthentication.login(
        phone: event.phone,
        password: event.password,
        role: event.role,
      );

      if (useCaseLogin.isOTPRequired) {
        emit(AuthenticationStateNavigateOTP());
      } else if (useCaseLogin.isLogin) {
        emit(AuthenticationStateNavigateLogin());
      } else {
        emit(AuthenticationStateResult(message: useCaseLogin.message!));
      }
    } catch (e) {
      emit(AuthenticationStateResult(message: ClientConstant.serverError));
    }
  }
}
