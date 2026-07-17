/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wash_your_cloth_mobile_app/data/client/client_constant.dart';

import '../../utilities/app_constant.dart';
import '../model/model_login.dart';

class LocalStorageService {
  final FlutterSecureStorage _secureStorage;

  LocalStorageService({FlutterSecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? FlutterSecureStorage();

  Future<void> saveAuthData({
    // required String token,
    // required String refreshToken,
    // required String expirationToken,
    // required String expirationRefreshToken,
    required ModelLogin modelLogin,
  }) async {
    await _secureStorage.write(
      key: ClientConstant.token,
      value: modelLogin.token,
    );
    await _secureStorage.write(
      key: ClientConstant.refreshToken,
      value: modelLogin.refreshToken,
    );
    await _secureStorage.write(
      key: ClientConstant.expirationToken,
      value: modelLogin.expirationToken.toIso8601String(),
    );
    await _secureStorage.write(
      key: ClientConstant.expirationRefreshToken,
      value: modelLogin.expirationRefreshToken.toIso8601String(),
    );
    await _secureStorage.write(
      key: ClientConstant.role,
      value: modelLogin.role,
    );
  }

  Future<String?> getToken() => _secureStorage.read(key: ClientConstant.token);

  Future<String?> getRefreshToken() =>
      _secureStorage.read(key: ClientConstant.refreshToken);

  Future<String?> getTokenExpiration() =>
      _secureStorage.read(key: ClientConstant.expirationToken);

  Future<String?> getRefreshTokenExpiration() =>
      _secureStorage.read(key: ClientConstant.expirationRefreshToken);

  Future<String?> getRole() => _secureStorage.read(key: ClientConstant.role);

  Future<void> clearAuthData() async {
    await _secureStorage.deleteAll();
  }

  Future<String> loginStatus() async {
    try {
      final token = await getToken();
      final refreshToken = await getRefreshToken();
      final tokenExpiration = await getTokenExpiration();
      final refreshTokenExpiration = await getRefreshTokenExpiration();

      // print("token::: $token");
      // print("refreshToken::: $refreshToken");
      // print("tokenExpiration::: $tokenExpiration");
      // print("refreshTokenExpiration::: $refreshTokenExpiration");

      if (token == null || refreshToken == null) {
        return ClientConstant.selectRole;
      }

      final nowDT = DateTime.now();
      final tokenExpirationDT = DateTime.parse(tokenExpiration!);

      if (tokenExpirationDT.isAfter(nowDT)) {
        return ClientConstant.dashboard;
      }

      final refreshTokenExpirationDT = DateTime.parse(refreshTokenExpiration!);

      if (refreshTokenExpirationDT.isAfter(nowDT)) {
        return ClientConstant.tokenRefresh;
      } else {
        return ClientConstant.selectRole;
      }
    } catch (e) {
      await clearAuthData();
      // return ClientConstant.retry;
      return ClientConstant.selectRole;
    }
  }

  // Future<String> checkToken() async {
  //   try {
  //     final token = await getToken();
  //     final refreshToken = await getRefreshToken();
  //     final tokenExpiration = await getTokenExpiration();
  //     final refreshTokenExpiration = await getRefreshTokenExpiration();
  //
  //     if (token == null || refreshToken == null) {
  //       return ClientConstant.logout;
  //     }
  //
  //     final nowDT = DateTime.now();
  //     final tokenExpirationDT = DateTime.parse(tokenExpiration!);
  //
  //     if (tokenExpirationDT.isAfter(nowDT)) {
  //       return ClientConstant.validToken;
  //     }
  //
  //     final refreshTokenExpirationDT = DateTime.parse(refreshTokenExpiration!);
  //
  //     if (refreshTokenExpirationDT.isAfter(nowDT)) {
  //       return ClientConstant.updateToken;
  //     } else {
  //       return ClientConstant.logout;
  //     }
  //   } catch (e) {
  //     return ClientConstant.logout;
  //   }
  // }
}
