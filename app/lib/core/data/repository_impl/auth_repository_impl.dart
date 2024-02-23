import 'dart:async';
import '../../../features/login/models/login_form_validation_model.dart';
import '../../api/exceptions/custom_exception.dart';
import '../../api/resource/resource.dart';
import '../../domain/entities/oauth_token_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_data_sources/auth_local_datasource.dart';
import '../data_sources/auth_data_sources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
      {required AuthRemoteDataSource remoteDataSource,
      required AuthLocalDataSource localDataSource})
      : _authRemoteDataSource = remoteDataSource,
        _authLocalDataSource = localDataSource;

  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  @override
  Future<Result<OauthTokenEntity>> loginUser(
      LoginRequestModel loginRequestModel) async {
    try {
      final response = await _authRemoteDataSource.loginUser(loginRequestModel);
      final tokenEntity = response.asEntity();
      _authLocalDataSource.cacheToken(tokenEntity);
      // RestClientModule.injectRefreshTokenInterceptor();
      return Result.success(tokenEntity);
    } on CustomException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<OauthTokenEntity>> fetchCachedToken() async {
    try {
      final tokenEntity = await _authLocalDataSource.getLastToken();
      // RestClientModule.injectRefreshTokenInterceptor();
      return Result.success(tokenEntity);
    } on CustomException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<void> logout() {
    return _authLocalDataSource.logout();
  }
}
