part of 'get_announcement_bloc.dart';

class GetAnnouncementEvent extends Equatable {
  final String? id;

  const GetAnnouncementEvent({this.id});

  @override
  List<Object?> get props => [id];
}

final class GetAnnouncement extends GetAnnouncementEvent {
  const GetAnnouncement({super.id});
}

final class RefreshAnnouncement extends GetAnnouncementEvent {
  final bool isDeleted;

  const RefreshAnnouncement({super.id, this.isDeleted = false});

  @override
  List<Object?> get props => [id, isDeleted];
}
