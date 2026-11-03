import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_data_entity.freezed.dart';
part 'login_data_entity.g.dart';

@freezed
abstract class LoginDataEntity with _$LoginDataEntity {
  const factory LoginDataEntity({
    String? accessToken,
    String? refreshToken,
  }) = _LoginDataEntity;

  factory LoginDataEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginDataEntityFromJson(json);
}
