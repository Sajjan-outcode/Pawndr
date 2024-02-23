import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_information_entity.g.dart';

@JsonSerializable()
class AppInformationEntity {
  final String androidLink;
  final String androidVersion;
  final String iosLink;
  final String iosVersion;

  AppInformationEntity(
      {required this.androidLink,
      required this.androidVersion,
      required this.iosLink,
      required this.iosVersion});
}
