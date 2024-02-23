import 'dart:ui';

import 'package:equatable/equatable.dart';

import '../entities/user_entity/user_entity.dart';

class UserDomain extends Equatable {
  final UserEntity _userEntity;
  bool isSelected;

  UserDomain(this._userEntity, this.isSelected);

  String get id => _userEntity.id;
  String get email => _userEntity.email;

  @override
  List<Object?> get props => [id];
}
