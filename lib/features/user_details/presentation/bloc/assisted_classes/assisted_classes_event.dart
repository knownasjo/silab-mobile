part of 'assisted_classes_bloc.dart';

sealed class AssistedClassesEvent extends Equatable {
  const AssistedClassesEvent();

  @override
  List<Object?> get props => [];
}

final class GetAssistedClasses extends AssistedClassesEvent {
  const GetAssistedClasses();
}

final class RefreshAssistedClasses extends AssistedClassesEvent {
  final String? classId;

  const RefreshAssistedClasses({this.classId});

  @override
  List<Object?> get props => [classId];
}
