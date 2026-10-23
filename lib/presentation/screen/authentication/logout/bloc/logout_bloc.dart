/*
Created by Neloy on 23 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/repository/repository_authentication.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final IRepositoryAuthentication repositoryAuthentication;

  LogoutBloc({required this.repositoryAuthentication})
    : super(const LogoutStateInitial()) {
    on<LogoutEventRequested>(_onLogoutRequested);
  }

  Future<void> _onLogoutRequested(
    LogoutEventRequested event,
    Emitter<LogoutState> emit,
  ) async {
    emit(const LogoutStateLoading());
    final result = await repositoryAuthentication.logout(
      allDevices: event.allDevices,
    );
    if (result.isSuccess) {
      emit(LogoutStateSuccess(message: result.message!));
    } else {
      emit(
        LogoutStateFailure(
          message: result.message!,
        ),
      );
    }
  }
}
