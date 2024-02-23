import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../models/outh_token_data/oauth_token_wrapper_data.dart';
import '../../../models/outh_token_data/outh_token_data.dart';

part 'auth_api_client.g.dart';

@RestApi()
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST('auth/login')
  Future<OauthTokenWrapperData> loginUser(
      @Body() Map<String, dynamic> loginRequestModel);

  @POST("oauth/token")
  Future<OauthTokenData> refreshToken(
      @Field("refresh_token") String refreshToken,
      @Field("grant_type") String grantType,
      @Field() String scopes);
}
