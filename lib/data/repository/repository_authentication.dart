/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/client/client_constant.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/authentication/api_login.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/authentication/api_registration.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/authentication/api_otp_verify.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/authentication/use_case_login.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/authentication/use_case_otp_verify.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/authentication/use_case_registration.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_constant.dart';

import '../local/local_storage_service.dart';
import '../network/api_call/authentication/api_refresh_token.dart';

abstract class IRepositoryAuthentication {
  Future<bool> getLoginStatus();
  Future<String> getRole();

  Future<UseCaseLogin> login({
    required String phone,
    required String password,
    required String role,
  });

  Future<UseCaseRegistration> registration({
    required RegistrationData registrationData,
  });

  Future<UseCaseOtpVerify> otpVerify({required OTPVerifyData otpVerifyData});
}

class RepositoryAuthentication implements IRepositoryAuthentication {
  final LocalStorageService localStorageService;
  final IApiRefreshToken apiRefreshToken;
  final IApiLogin apiLogin;
  final IApiRegistration apiRegistration;
  final IApiOTPVerify apiOTPVerify;

  const RepositoryAuthentication({
    required this.localStorageService,
    required this.apiRefreshToken,
    required this.apiLogin,
    required this.apiRegistration,
    required this.apiOTPVerify,
  });

  @override
  Future<bool> getLoginStatus() async {
    try {
      String result = await localStorageService.loginStatus(
        // positiveStatus: ClientConstant.dashboard,
        // negativeStatus: ClientConstant.selectRole,
        // tokenStatus: ClientConstant.tokenRefresh,
      );

      if (result == ClientConstant.dashboard) {
        return true;
      } else if (result == ClientConstant.tokenRefresh) {
        String? currentRefreshToken = await localStorageService
            .getRefreshToken();
        Map<String, dynamic> data = {
          ClientConstant.refreshToken: currentRefreshToken,
        };
        var (modelLogin, modelError) = await apiRefreshToken.refreshToken(
          data: data,
        );
        if (modelError == null) {
          await localStorageService.clearAuthData();
          // await localStorageService.saveAuthData(
          //   token: modelLogin!.token,
          //   refreshToken: modelLogin.refreshToken,
          //   expirationToken: modelLogin.expirationToken.toIso8601String(),
          //   expirationRefreshToken: modelLogin.expirationRefreshToken
          //       .toIso8601String(),
          // );
          // await _initializeToken(modelLogin: modelLogin!);
          await localStorageService.saveAuthData(modelLogin: modelLogin!);
          return true;
        } else {
          return await _handleSessionFailure();
        }
      } else if (result == ClientConstant.selectRole) {
        return await _handleSessionFailure();
      }
      return await _handleSessionFailure();
      // return false;
    } catch (e) {
      return await _handleSessionFailure();
    }
  }

  @override
  Future<UseCaseLogin> login({
    required String phone,
    required String password,
    required String role,
  }) async {
    try {
      Map<String, dynamic> data = {
        ClientConstant.phone: phone,
        ClientConstant.password: password,
        ClientConstant.role: role,
      };
      var (modelLogin, modelLoginUnverified, modelError) = await apiLogin.login(
        data: data,
      );

      if (modelLogin != null) {
        await localStorageService.saveAuthData(modelLogin: modelLogin);
        return UseCaseLogin(isOTPRequired: false, isLogin: true);
      } else if (modelLoginUnverified != null) {
        final result = await _loginFailedResult(
          message: modelLoginUnverified.message,
          isOTP: true,
          otpRequestId: modelLoginUnverified.otpRequestId,
          recordId: modelLoginUnverified.recordId,
        );
        return result;
      } else {
        final result = await _loginFailedResult(
          message: modelError?.error?.isNotEmpty == true
              ? modelError!.error!.first
              : ClientConstant.serverError,
          isOTP: false,
        );
        return result;
      }
    } catch (e) {
      final result = await _loginFailedResult(
        message: ClientConstant.serverError,
        isOTP: false,
      );
      return result;
    }
  }

  Future<bool> _handleSessionFailure() async {
    await localStorageService.clearAuthData();
    return false;
  }

  // Future<void> _initializeToken({required ModelLogin modelLogin}) async {
  //   await localStorageService.saveAuthData(
  //     token: modelLogin.token,
  //     refreshToken: modelLogin.refreshToken,
  //     expirationToken: modelLogin.expirationToken.toIso8601String(),
  //     expirationRefreshToken: modelLogin.expirationRefreshToken
  //         .toIso8601String(),
  //   );
  // }

  Future<UseCaseLogin> _loginFailedResult({
    required bool isOTP,
    String? message,
    String? otpRequestId,
    String? recordId,
  }) async {
    await localStorageService.clearAuthData();
    return UseCaseLogin(
      isOTPRequired: isOTP,
      isLogin: false,
      message: message,
      otpRequestId: otpRequestId,
      recordId: recordId,
    );
  }

  @override
  Future<UseCaseRegistration> registration({
    required RegistrationData registrationData,
  }) async {
    Map<String, dynamic> data;
    try {
      if (registrationData.role == Role.user.name) {
        data = registrationData.toMapUser();
      } else {
        data = registrationData.toMapShop();
      }

      var (modelLoginUnverified, modelError) = await apiRegistration
          .registration(data: data);

      if (modelError == null) {
        return UseCaseRegistration(
          message: modelLoginUnverified!.message,
          recordId: modelLoginUnverified.recordId,
          otpRequestId: modelLoginUnverified.otpRequestId,
          isNavigateOTP: true,
        );
      } else {
        return UseCaseRegistration(
          message: modelError.error?.isNotEmpty == true
              ? modelError.error!.first
              : ClientConstant.serverError,
          isNavigateOTP: false,
        );
      }
    } catch (e) {
      return UseCaseRegistration(
        message: ClientConstant.serverError,
        isNavigateOTP: false,
      );
    }
  }

  @override
  Future<UseCaseOtpVerify> otpVerify({
    required OTPVerifyData otpVerifyData,
  }) async {
    try {
      var (message, modelError) = await apiOTPVerify.verify(
        data: otpVerifyData.toMap(),
      );

      if (modelError == null) {
        return UseCaseOtpVerify(message: message!, isVerify: true);
      } else {
        return UseCaseOtpVerify(
          message: modelError.error?.isNotEmpty == true
              ? modelError.error!.first
              : ClientConstant.serverError,
          isVerify: false,
        );
      }
    } catch (e) {
      return UseCaseOtpVerify(
        message: ClientConstant.serverError,
        isVerify: false,
      );
    }
  }

  @override
  Future<String> getRole() async {
    String? role =  await localStorageService.getRole();
    return role.toString();
  }
}
