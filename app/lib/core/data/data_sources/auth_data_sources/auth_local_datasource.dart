import 'dart:convert';

import '../../../../services/local_storage_service/local_storage_service.dart';
import '../../../api/exceptions/custom_exception.dart';
import '../../../domain/entities/oauth_token_entity.dart';
import '../../../domain/entities/user_entity/user_entity.dart';

abstract class AuthLocalDataSource {
  Future<OauthTokenEntity> getLastToken();
  Future<void> cacheToken(OauthTokenEntity loginEntity);
  Future<void> logout();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final LocalStorageService _localStorageService;

  AuthLocalDataSourceImpl({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  @override
  Future<void> cacheToken(OauthTokenEntity loginEntity) {
    _localStorageService.setAccessToken(loginEntity.token);
    _localStorageService.setRefreshToken(loginEntity.refreshToken);
    _localStorageService.setUserId(loginEntity.user.id);
    _localStorageService
        .setAccessTokenDuration(loginEntity.expiration.toString());
    _localStorageService
        .setRefreshTokenDuration(loginEntity.refreshTokenExpiration.toString());
    _localStorageService.setUser(jsonEncode(loginEntity.user));
    return _localStorageService.setRefreshToken(loginEntity.refreshToken);
  }

  @override
  Future<OauthTokenEntity> getLastToken() async {
    String? accessToken = await _localStorageService.accessToken;
    String? refreshToken = await _localStorageService.refreshToken;
    String? refreshTokenDuration =
        await _localStorageService.refreshTokenDuration;
    String? accessTokenDuration =
        await _localStorageService.accessTokenDuration;
    String? user = await _localStorageService.user;

    if (accessToken == null ||
        refreshToken == null ||
        user == null ||
        accessTokenDuration == null ||
        refreshTokenDuration == null) {
      throw CustomException.sessionExpired();
    }
    int? intRefreshTokenDuration = int.tryParse(refreshTokenDuration);
    int? intAccessTokenDuration = int.tryParse(accessTokenDuration);
    UserEntity userEntity = UserEntity.fromJson(jsonDecode(user));

    if (intRefreshTokenDuration == null || intAccessTokenDuration == null) {
      throw CustomException.sessionExpired();
    }

    return Future.value(OauthTokenEntity(
        token: accessToken,
        refreshToken: refreshToken,
        refreshTokenExpiration: intRefreshTokenDuration,
        expiration: intAccessTokenDuration,
        user: userEntity));
  }

  @override
  Future<void> logout() {
    _localStorageService.setAccessToken(null);
    _localStorageService.setRefreshToken(null);
    _localStorageService.setUserId(null);
    _localStorageService.setAccessTokenDuration(null);
    _localStorageService.setRefreshTokenDuration(null);
    _localStorageService.setUser(null);
    return _localStorageService.setRefreshToken(null);
  }
}
