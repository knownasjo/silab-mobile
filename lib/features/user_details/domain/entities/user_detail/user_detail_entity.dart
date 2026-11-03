import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_detail_entity.freezed.dart';
part 'user_detail_entity.g.dart';

@freezed
abstract class UserDetailEntity with _$UserDetailEntity {
  const factory UserDetailEntity({
    String? nim,
    @JsonKey(name: 'name') String? fullname,
    String? email,
  }) = _UserDetailEntity;

  factory UserDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$UserDetailEntityFromJson(json);
}
