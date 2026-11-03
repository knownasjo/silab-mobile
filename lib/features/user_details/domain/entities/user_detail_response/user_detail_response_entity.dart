import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/features/user_details/domain/entities/user_detail/user_detail_entity.dart';

part 'user_detail_response_entity.freezed.dart';
part 'user_detail_response_entity.g.dart';

@freezed
abstract class UserDetailResponseEntity with _$UserDetailResponseEntity {
  const factory UserDetailResponseEntity({
    bool? status,
    String? message,
    UserDetailEntity? data,
  }) = _UserDetailResponseEntity;

  factory UserDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UserDetailResponseEntityFromJson(json);
}
