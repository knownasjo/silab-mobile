import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_selected_class_response_entity.freezed.dart';
part 'add_selected_class_response_entity.g.dart';

@freezed
abstract class AddSelectedClassResponseEntity with _$AddSelectedClassResponseEntity {
  const factory AddSelectedClassResponseEntity({
    bool? status,
    String? message,
  }) = _AddSelectedClassResponseEntity;

  factory AddSelectedClassResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$AddSelectedClassResponseEntityFromJson(json);
}
