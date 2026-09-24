import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/features/announcement/presentation/blocs/get_all_announcements/get_all_announcements_bloc.dart';
import 'package:silab/features/announcement/presentation/blocs/get_announcement/get_announcement_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/classmates/classmates_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_meetings/user_meetings_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';
import 'package:silab/features/realtime/domain/entities/realtime_event_entity.dart';
import 'package:silab/features/realtime/presentation/bloc/realtime_bloc.dart';
import 'package:silab/features/schedule/presentation/bloc/user_schedule_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/selected_subject_by_nim/selected_subject_by_nim_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_event.dart';
import 'package:silab/features/subjects/presentation/bloc/subject_list/subject_list_bloc.dart';
import 'package:silab/features/user_details/presentation/bloc/assisted_classes/assisted_classes_bloc.dart';

class RealtimeSync extends StatefulWidget {
  final Widget child;

  const RealtimeSync({super.key, required this.child});

  @override
  State<RealtimeSync> createState() => _RealtimeSyncState();
}

class _RealtimeSyncState extends State<RealtimeSync> {
  late final RealtimeBloc _realtimeBloc;
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    _realtimeBloc = context.read<RealtimeBloc>()..add(const StartRealtime());
    _lifecycleListener = AppLifecycleListener(
      onShow: () => _realtimeBloc.add(const StartRealtime()),
    );
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    _realtimeBloc.add(const StopRealtime());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RealtimeBloc, RealtimeState>(
      listenWhen: (_, current) => current is RealtimeMessage,
      listener: (context, state) => _onMessage(state.message!),
      child: widget.child,
    );
  }

  void _onMessage(RealtimeEventEntity message) {
    switch (message.type) {
      case 'ready':
        _refreshEverything();
      case 'announcement':
        _refreshAnnouncements(message);
      case 'subject':
        context.read<SubjectListBloc>().add(const RefreshSubjectList());
      case 'class':
        _refreshClass(message);
      case 'activation':
        _refreshRegistration();
      case 'meeting' || 'attendance':
        context
            .read<UserMeetingsBloc>()
            .add(RefreshUserMeetings(classId: message.classId));
    }
  }

  void _refreshEverything() {
    context.read<AssistedClassesBloc>().add(const RefreshAssistedClasses());
    context.read<GetAllAnnouncementsBloc>().add(RefreshAllAnnouncements());
    context.read<SubjectListBloc>().add(const RefreshSubjectList());
    context.read<ClassmatesBloc>().add(const RefreshClassmates());
    context.read<UserMeetingsBloc>().add(const RefreshUserMeetings());
    _refreshRegistration();
  }

  void _refreshAnnouncements(RealtimeEventEntity message) {
    context.read<GetAllAnnouncementsBloc>().add(RefreshAllAnnouncements());
    context.read<GetAnnouncementBloc>().add(RefreshAnnouncement(
          id: message.announcementId,
          isDeleted: message.action == 'deleted',
        ));
  }

  void _refreshClass(RealtimeEventEntity message) {
    final classOptions = context
            .read<UserClassOptionByPaidSubjectBloc>()
            .state
            .userClassOptionByPaidSubjectEntity ??
        const [];

    if (message.action == 'created' ||
        classOptions.any((option) => option.class_id == message.classId)) {
      context
          .read<UserClassOptionByPaidSubjectBloc>()
          .add(RefreshUserClassOptionByPaidSubject());
    }

    context
        .read<ClassmatesBloc>()
        .add(RefreshClassmates(classId: message.classId));
    context.read<AssistedClassesBloc>().add(const RefreshAssistedClasses());
  }

  void _refreshRegistration() {
    context.read<SelectedSubjectByNimBloc>().add(RefreshUserSelectedSubjects());
    context
        .read<UserClassOptionByPaidSubjectBloc>()
        .add(RefreshUserClassOptionByPaidSubject());
    context.read<UserRegisteredClassBloc>().add(RefreshUserRegisteredClass());
    context.read<UserScheduleBloc>().add(RefreshUserSchedule());
  }
}
