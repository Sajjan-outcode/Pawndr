import 'user_entity/user_entity.dart';

class OauthTokenEntity {
  String token;
  String refreshToken;
  int refreshTokenExpiration;
  int expiration;
  UserEntity user;

  OauthTokenEntity(
      {required this.token,
      required this.refreshToken,
      required this.refreshTokenExpiration,
      required this.expiration,
      required this.user});
}
