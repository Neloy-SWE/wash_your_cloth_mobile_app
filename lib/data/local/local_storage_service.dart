/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wash_your_cloth_mobile_app/data/client/client_constant.dart';

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

  Future<String> getOrCreateInstallationId() async {
    final storedId = await _secureStorage.read(
      key: ClientConstant.installationId,
    );
    if (storedId != null && storedId.isNotEmpty) return storedId;

    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0'));
    final value = hex.join();
    final installationId =
        '${value.substring(0, 8)}-${value.substring(8, 12)}-'
        '${value.substring(12, 16)}-${value.substring(16, 20)}-'
        '${value.substring(20)}';
    await _secureStorage.write(
      key: ClientConstant.installationId,
      value: installationId,
    );
    return installationId;
  }

  Future<void> clearAuthData() async {
    await Future.wait([
      _secureStorage.delete(key: ClientConstant.token),
      _secureStorage.delete(key: ClientConstant.refreshToken),
      _secureStorage.delete(key: ClientConstant.expirationToken),
      _secureStorage.delete(key: ClientConstant.expirationRefreshToken),
      _secureStorage.delete(key: ClientConstant.role),
    ]);
  }

  Future<String> loginStatus() async {
    try {
      final token = await getToken();
      final refreshToken = await getRefreshToken();
      final refreshTokenExpiration = await getRefreshTokenExpiration();

      // print("token::: $token");
      // print("refreshToken::: $refreshToken");
      // print("tokenExpiration::: $tokenExpiration");
      // print("refreshTokenExpiration::: $refreshTokenExpiration");

      if (token == null || refreshToken == null) {
        return ClientConstant.selectRole;
      }

      final nowDT = DateTime.now();
      final refreshTokenExpirationDT = DateTime.parse(refreshTokenExpiration!);

      if (refreshTokenExpirationDT.isAfter(nowDT)) {
        // Validate the server-side session and rotate its refresh token at startup.
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
