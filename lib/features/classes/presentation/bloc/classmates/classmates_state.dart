part of 'classmates_bloc.dart';

class ClassmatesState extends Equatable {
  final String? message;
  final List<ClassmateEntity>? classmates;

  const ClassmatesState({
    this.classmates,
    this.message,
  });

  @override
  List<Object?> get props => [classmates, message];
}

final class ClassmatesInitial extends ClassmatesState {}

final class ClassmatesLoading extends ClassmatesState {}

final class ClassmatesLoaded extends ClassmatesState {
  const ClassmatesLoaded({super.classmates});
}

final class ClassmatesFailed extends ClassmatesState {
  const ClassmatesFailed({super.message});
}
