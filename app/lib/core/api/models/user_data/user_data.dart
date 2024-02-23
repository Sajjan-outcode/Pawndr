import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/user_entity/user_entity.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  final int id;
  final String email;
  UserData(this.id, this.email);

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  UserEntity asEntity() => UserEntity(id.toString(), email);
}
