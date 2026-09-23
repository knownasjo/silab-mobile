part of 'classmates_bloc.dart';

class ClassmatesEvent extends Equatable {
  final String? classId;

  const ClassmatesEvent({this.classId});

  @override
  List<Object?> get props => [classId];
}

final class GetClassmates extends ClassmatesEvent {
  const GetClassmates({super.classId});
}

final class RefreshClassmates extends ClassmatesEvent {
  const RefreshClassmates({super.classId});
}
