part of 'user_meetings_bloc.dart';

class UserMeetingsEvent extends Equatable {
  final String? classId;

  const UserMeetingsEvent({this.classId});

  @override
  List<Object?> get props => [classId];
}

final class GetUserMeetings extends UserMeetingsEvent {
  const GetUserMeetings({super.classId});
}

final class RefreshUserMeetings extends UserMeetingsEvent {
  const RefreshUserMeetings({super.classId});
}

final class WatchUserMeetings extends UserMeetingsEvent {
  const WatchUserMeetings({super.classId});
}

final class StopWatchingUserMeetings extends UserMeetingsEvent {
  const StopWatchingUserMeetings();
}
