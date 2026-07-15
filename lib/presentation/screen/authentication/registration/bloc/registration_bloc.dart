/* 
Created by Neloy on 10 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/authentication/use_case_registration.dart';

import '../../../../../data/client/client_constant.dart';
import '../../../../../data/repository/repository_authentication.dart';

part 'registration_state.dart';

part 'registration_event.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final IRepositoryAuthentication repositoryAuthentication;

  RegistrationBloc({required this.repositoryAuthentication})
    : super(RegistrationStateInitial()) {
    on<RegistrationEventRegistration>(_onRegistration);
  }

  Future<void> _onRegistration(
    RegistrationEventRegistration event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationStateLoading());
    try {
      RegistrationData registrationData = RegistrationData(
        address: event.address,
        closeTime: event.closeTime,
        firstName: event.firstName,
        lastName: event.lastName,
        openTime: event.openTime,
        password: event.password,
        phone: event.phone,
        role: event.role,
        shopName: event.shopName,
        weekends: event.weekends,
      );

      UseCaseRegistration useCaseRegistration = await repositoryAuthentication
          .registration(registrationData: registrationData);

      if (useCaseRegistration.isNavigateOTP) {
        emit(
          RegistrationStateNavigateOTP(
            otpRequestId: useCaseRegistration.otpRequestId!,
            recordId: useCaseRegistration.recordId!,
            message: useCaseRegistration.message!,
          ),
        );
      } else {
        emit(RegistrationStateResult(message: useCaseRegistration.message!));
      }
    } catch (e) {
      emit(RegistrationStateResult(message: ClientConstant.serverError));
    }
  }
}
