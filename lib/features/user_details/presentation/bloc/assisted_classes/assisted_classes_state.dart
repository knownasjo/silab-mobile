part of 'assisted_classes_bloc.dart';

sealed class AssistedClassesState extends Equatable {
  const AssistedClassesState();

  @override
  List<Object?> get props => [];
}

final class AssistedClassesInitial extends AssistedClassesState {
  const AssistedClassesInitial();
}

final class AssistedClassesLoading extends AssistedClassesState {
  const AssistedClassesLoading();
}

final class AssistedClassesLoaded extends AssistedClassesState {
  final List<AssistedClassEntity> classes;

  const AssistedClassesLoaded(this.classes);

  @override
  List<Object?> get props => [classes];
}

final class AssistedClassesFailed extends AssistedClassesState {
  final String message;

  const AssistedClassesFailed(this.message);

  @override
  List<Object?> get props => [message];
}
