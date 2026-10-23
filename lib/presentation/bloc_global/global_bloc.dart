/* 
Created by Neloy on 28 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/client/auth_session_expiry_notifier.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_authentication.dart';

import '../../utilities/app_constant.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final IRepositoryAuthentication repositoryAuthentication;
  final AuthSessionExpiryNotifier authSessionExpiryNotifier;
  late final StreamSubscription<bool> _sessionExpirySubscription;

  GlobalBloc({
    required this.repositoryAuthentication,
    required this.authSessionExpiryNotifier,
  }) : super(GlobalState()) {
    _sessionExpirySubscription = authSessionExpiryNotifier.sessionExpired
        .listen(_onSessionExpired);
    on<GlobalEventSetRole>(_onSetRole);
    on<GlobalEventLogoutCompleted>(_onLogoutCompleted);
    on<GlobalEventSessionExpired>(_onSessionExpiredEvent);
    // on<GlobalEventSetOTPNavigation>(_onSetOTPNavigation);
    // on<GlobalEventSetPhone>(_onSetPhone);
    on<GlobalEventGetLoginStatus>(_onGetLoginStatus);
    // on<GlobalEventSetOTPInfo>(_onSetOTPInfo);
  }

  void _onSetRole(GlobalEventSetRole event, Emitter<GlobalState> emit) {
    emit(state.copyWith(role: event.role, sessionExpired: false));
  }

  void _onLogoutCompleted(
    GlobalEventLogoutCompleted event,
    Emitter<GlobalState> emit,
  ) {
    emit(GlobalState(isLogin: false));
  }

  void _onSessionExpired(bool deferRedirectUntilResultDismissed) {
    if (!isClosed) {
      add(
        GlobalEventSessionExpired(
          deferRedirectUntilResultDismissed: deferRedirectUntilResultDismissed,
        ),
      );
    }
  }

  void _onSessionExpiredEvent(
    GlobalEventSessionExpired event,
    Emitter<GlobalState> emit,
  ) {
    emit(
      GlobalState(
        isLogin: false,
        sessionExpired: true,
        deferRedirectUntilResultDismissed:
            event.deferRedirectUntilResultDismissed,
      ),
    );
  }

  // void _onSetOTPNavigation(
  //   GlobalEventSetOTPNavigation event,
  //   Emitter<GlobalState> emit,
  // ) {
  //   emit(state.copyWith(otpNavigation: event.otpNavigation));
  // }
  //
  // void _onSetPhone(GlobalEventSetPhone event, Emitter<GlobalState> emit) {
  //   emit(state.copyWith(phone: event.phone));
  // }

  Future<void> _onGetLoginStatus(
    GlobalEventGetLoginStatus event,
    Emitter<GlobalState> emit,
  ) async {
    bool isLogin = await repositoryAuthentication.getLoginStatus();

    if (isLogin) {
      String role = await repositoryAuthentication.getRole();
      emit(state.copyWith(isLogin: isLogin, role: Role.values.byName(role)));
    } else {
      emit(state.copyWith(isLogin: isLogin));
    }
  }

  @override
  Future<void> close() async {
    await _sessionExpirySubscription.cancel();
    return super.close();
  }

  // Future<void> _onSetOTPInfo(
  //   GlobalEventSetOTPInfo event,
  //   Emitter<GlobalState> emit,
  // ) async {
  //   emit(
  //     state.copyWith(
  //       otpRequestId: event.otpRequestId,
  //       recordId: event.recordId,
  //     ),
  //   );
  // }
}
