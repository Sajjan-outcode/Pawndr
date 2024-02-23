// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outh_token_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OauthTokenData _$OauthTokenDataFromJson(Map<String, dynamic> json) =>
    OauthTokenData(
      json['token'] as String,
      json['refresh_token'] as String,
      json['expiration'] as int,
      json['refresh_token_expiration'] as int,
      UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OauthTokenDataToJson(OauthTokenData instance) =>
    <String, dynamic>{
      'token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expiration': instance.expiration,
      'refresh_token_expiration': instance.refreshTokenExpiration,
      'user': instance.user,
    };
