/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/client/client_constant.dart';

import '../local/local_storage_service.dart';
import '../network/api_call/api_refresh_token.dart';

abstract class IRepositoryAuthentication {
  Future<bool> getLoginStatus();
}

class RepositoryAuthentication extends IRepositoryAuthentication {
  final LocalStorageService localStorageService;
  final IApiRefreshToken apiRefreshToken;

  RepositoryAuthentication({
    required this.localStorageService,
    required this.apiRefreshToken,
  });

  @override
  Future<bool> getLoginStatus() async {
    try {
      String result = await localStorageService.loginStatus();

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
          await localStorageService.saveAuthData(
            token: modelLogin!.token,
            refreshToken: modelLogin.refreshToken,
            expirationToken: modelLogin.expirationToken.toIso8601String(),
            expirationRefreshToken: modelLogin.expirationRefreshToken
                .toIso8601String(),
          );
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

  Future<bool> _handleSessionFailure() async {
    await localStorageService.clearAuthData();
    return false;
  }
}
