import '../../../../features/login/models/login_form_validation_model.dart';
import '../../../api/clients/rest_client/auth_api_client/auth_api_client.dart';
import '../../../api/exceptions/exception_handler.dart';
import '../../../api/models/outh_token_data/outh_token_data.dart';

abstract class AuthRemoteDataSource {
  Future<OauthTokenData> loginUser(LoginRequestModel loginRequestModel);
  Future<OauthTokenData> refreshToken(
      String refreshToken, String grantType, String scopes);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required AuthApiClient authApiClient})
      : _authApiClient = authApiClient;

  final AuthApiClient _authApiClient;

  @override
  Future<OauthTokenData> loginUser(LoginRequestModel loginRequestModel) async {
    try {
      Map<String, dynamic> json = {
        "email": loginRequestModel.email,
        "password": loginRequestModel.password
      };
      OauthTokenData loginData = (await _authApiClient.loginUser(json)).data;
      return loginData;
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  @override
  Future<OauthTokenData> refreshToken(
      String refreshToken, String grantType, String scopes) async {
    try {
      return await _authApiClient.refreshToken(refreshToken, grantType, scopes);
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
