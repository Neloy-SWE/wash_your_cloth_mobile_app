/* 
Created by Neloy on 28 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_authentication.dart';

import '../../utilities/app_constant.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final IRepositoryAuthentication repositoryAuthentication;

  GlobalBloc({required this.repositoryAuthentication}) : super(GlobalState()) {
    on<GlobalEventSetRole>(_onSetRole);
    on<GlobalEventSetOTPNavigation>(_onSetOTPNavigation);
    on<GlobalEventSetPhone>(_onSetPhone);
    on<GlobalEventGetLoginStatus>(_onGetLoginStatus);
  }

  void _onSetRole(GlobalEventSetRole event, Emitter<GlobalState> emit) {
    emit(state.copyWith(role: event.role));
  }

  void _onSetOTPNavigation(
    GlobalEventSetOTPNavigation event,
    Emitter<GlobalState> emit,
  ) {
    emit(state.copyWith(otpNavigation: event.otpNavigation));
  }

  void _onSetPhone(GlobalEventSetPhone event, Emitter<GlobalState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  Future<void> _onGetLoginStatus(
    GlobalEventGetLoginStatus event,
    Emitter<GlobalState> emit,
  ) async {
    bool isLogin = await repositoryAuthentication.getLoginStatus();
    emit(state.copyWith(isLogin: isLogin));
  }
}
