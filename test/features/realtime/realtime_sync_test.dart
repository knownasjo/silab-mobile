import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silab/features/announcement/domain/repository/announcement_repository.dart';
import 'package:silab/features/announcement/domain/usecases/get_all_announcements_usecase.dart';
import 'package:silab/features/announcement/domain/usecases/get_announcement_usecase.dart';
import 'package:silab/features/announcement/presentation/blocs/get_all_announcements/get_all_announcements_bloc.dart';
import 'package:silab/features/announcement/presentation/blocs/get_announcement/get_announcement_bloc.dart';
import 'package:silab/features/classes/domain/repository/class_repository.dart';
import 'package:silab/features/classes/domain/usecases/get_classmates_usecase.dart';
import 'package:silab/features/classes/domain/usecases/get_user_meetings_data_usecase.dart';
import 'package:silab/features/classes/domain/usecases/get_user_registered_classes_usecase.dart';
import 'package:silab/features/classes/presentation/bloc/classmates/classmates_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_meetings/user_meetings_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';
import 'package:silab/features/realtime/domain/entities/realtime_event_entity.dart';
import 'package:silab/features/realtime/domain/repository/realtime_repository.dart';
import 'package:silab/features/realtime/domain/usecases/watch_realtime_events_usecase.dart';
import 'package:silab/features/realtime/presentation/bloc/realtime_bloc.dart';
import 'package:silab/features/realtime/presentation/widgets/realtime_sync.dart';
import 'package:silab/features/schedule/domain/repository/schedule_repository.dart';
import 'package:silab/features/schedule/domain/usecases/get_user_schedule_usecase.dart';
import 'package:silab/features/schedule/presentation/bloc/user_schedule_bloc.dart';
import 'package:silab/features/select_subjects/domain/repository/selected_subject_repository.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_class_option_by_paid_subject_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_selected_subject_usecase.dart';
import 'package:silab/features/select_subjects/presentation/bloc/selected_subject_by_nim/selected_subject_by_nim_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_event.dart';
import 'package:silab/features/subjects/domain/repository/subject_repository.dart';
import 'package:silab/features/subjects/domain/usecases/get_subject_list_usecase.dart';
import 'package:silab/features/subjects/presentation/bloc/subject_list/subject_list_bloc.dart';
import 'package:silab/features/user_details/domain/repositories/user_repository.dart';
import 'package:silab/features/user_details/domain/usecases/get_assisted_classes_usecase.dart';
import 'package:silab/features/user_details/presentation/bloc/assisted_classes/assisted_classes_bloc.dart';

class FakeRepositories
    implements
        AnnouncementRepository,
        ClassRepository,
        ScheduleRepository,
        SelectedSubjectRepository,
        SubjectRepository,
        UserRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeRealtimeRepository implements RealtimeRepository {
  final controller = StreamController<RealtimeEventEntity>.broadcast();

  @override
  Stream<RealtimeEventEntity> watchEvents() => controller.stream;
}

class EventRecorder extends BlocObserver {
  final List<Object?> events = [];

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (bloc is! RealtimeBloc) events.add(event);
  }
}

final refreshEverything = [
  isA<RefreshAssistedClasses>(),
  isA<RefreshAllAnnouncements>(),
  isA<RefreshSubjectList>(),
  isA<RefreshClassmates>(),
  isA<RefreshUserMeetings>(),
  isA<RefreshUserSelectedSubjects>(),
  isA<RefreshUserClassOptionByPaidSubject>(),
  isA<RefreshUserRegisteredClass>(),
  isA<RefreshUserSchedule>(),
];

void main() {
  late BlocObserver previousObserver;
  late EventRecorder recorder;
  late FakeRealtimeRepository realtime;

  setUp(() {
    previousObserver = Bloc.observer;
    recorder = EventRecorder();
    Bloc.observer = recorder;
    realtime = FakeRealtimeRepository();
  });

  tearDown(() {
    Bloc.observer = previousObserver;
    realtime.controller.close();
  });

  Future<void> send(WidgetTester tester, RealtimeEventEntity message) async {
    realtime.controller.add(message);
    await tester.pump();
    await tester.pump();
  }

  Future<void> connect(WidgetTester tester) async {
    final repositories = FakeRepositories();

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RealtimeBloc(WatchRealtimeEventsUsecase(realtime)),
        ),
        BlocProvider(
          create: (_) =>
              AssistedClassesBloc(GetAssistedClassesUsecase(repositories)),
        ),
        BlocProvider(
          create: (_) =>
              GetAllAnnouncementsBloc(GetAllAnnouncementsUseCase(repositories)),
        ),
        BlocProvider(
          create: (_) =>
              GetAnnouncementBloc(GetAnnouncementUseCase(repositories)),
        ),
        BlocProvider(
          create: (_) => SubjectListBloc(GetSubjectListUseCase(repositories)),
        ),
        BlocProvider(
          create: (_) => ClassmatesBloc(GetClassmatesUsecase(repositories)),
        ),
        BlocProvider(
          create: (_) =>
              UserMeetingsBloc(GetUserMeetingsDataUsecase(repositories)),
        ),
        BlocProvider(
          create: (_) => SelectedSubjectByNimBloc(
              GetSelectedSubjectByNimUsecase(repositories)),
        ),
        BlocProvider(
          create: (_) => UserClassOptionByPaidSubjectBloc(
              GetUserClassOptionByPaidSubjectUsecase(repositories)),
        ),
        BlocProvider(
          create: (_) => UserRegisteredClassBloc(
              GetUserRegisteredClassesUseCase(repositories)),
        ),
        BlocProvider(
          create: (_) => UserScheduleBloc(GetUserScheduleUsecase(repositories)),
        ),
      ],
      child: const RealtimeSync(child: SizedBox()),
    ));

    await send(tester, const RealtimeEventEntity(type: 'ready'));
    expect(recorder.events, isEmpty);
  }

  testWidgets('semester baru dimulai: semua layar dimuat ulang',
      (tester) async {
    await connect(tester);

    await send(
      tester,
      const RealtimeEventEntity(type: 'period', action: 'started'),
    );

    expect(recorder.events, unorderedMatches(refreshEverything));
  });

  testWidgets('tersambung ulang: semua layar disusul', (tester) async {
    await connect(tester);

    await send(tester, const RealtimeEventEntity(type: 'ready'));

    expect(recorder.events, unorderedMatches(refreshEverything));
  });

  testWidgets('mata kuliah berubah: hanya daftar mata kuliah yang dimuat ulang',
      (tester) async {
    await connect(tester);

    await send(tester, const RealtimeEventEntity(type: 'subject'));

    expect(recorder.events, [isA<RefreshSubjectList>()]);
  });

  testWidgets(
      'pendaftaran berubah: pengumuman ikut dimuat ulang, karena ada pengumuman untuk mata kuliah tertentu',
      (tester) async {
    await connect(tester);

    await send(tester, const RealtimeEventEntity(type: 'activation'));

    expect(
      recorder.events,
      unorderedMatches([
        isA<RefreshUserSelectedSubjects>(),
        isA<RefreshUserClassOptionByPaidSubject>(),
        isA<RefreshUserRegisteredClass>(),
        isA<RefreshUserSchedule>(),
        isA<RefreshAllAnnouncements>(),
      ]),
    );
  });

  testWidgets('asisten kelas berubah: pengumuman ikut dimuat ulang',
      (tester) async {
    await connect(tester);

    await send(
      tester,
      const RealtimeEventEntity(
          type: 'class', action: 'assistants', classId: 'c1'),
    );

    expect(recorder.events, contains(isA<RefreshAllAnnouncements>()));
  });

  testWidgets('kelas biasa berubah: pengumuman tidak dimuat ulang',
      (tester) async {
    await connect(tester);

    await send(
      tester,
      const RealtimeEventEntity(
          type: 'class', action: 'updated', classId: 'c1'),
    );

    expect(recorder.events, isNot(contains(isA<RefreshAllAnnouncements>())));
  });
}
