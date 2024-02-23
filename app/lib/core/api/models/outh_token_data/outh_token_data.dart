import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/oauth_token_entity.dart';
import '../user_data/user_data.dart';

part 'outh_token_data.g.dart';

@JsonSerializable()
class OauthTokenData {
  @JsonKey(name: "token")
  final String accessToken;

  @JsonKey(name: "refresh_token")
  final String refreshToken;

  @JsonKey(name: "expiration")
  final int expiration;

  @JsonKey(name: "refresh_token_expiration")
  final int refreshTokenExpiration;

  @JsonKey(name: "user")
  final UserData user;

  OauthTokenData(this.accessToken, this.refreshToken, this.expiration,
      this.refreshTokenExpiration, this.user);

  factory OauthTokenData.fromJson(Map<String, dynamic> json) =>
      _$OauthTokenDataFromJson(json);
  Map<String, dynamic> toJson() => _$OauthTokenDataToJson(this);

  OauthTokenEntity asEntity() => OauthTokenEntity(
      token: accessToken,
      refreshToken: refreshToken,
      refreshTokenExpiration: refreshTokenExpiration,
      expiration: expiration,
      user: user.asEntity());
}
