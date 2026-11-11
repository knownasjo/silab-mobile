import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silab/features/announcement/domain/entities/announcement/announcement_entity.dart';
import 'package:silab/features/announcement/domain/repository/announcement_repository.dart';
import 'package:silab/features/announcement/domain/usecases/get_all_announcements_usecase.dart';
import 'package:silab/features/announcement/domain/usecases/get_announcement_usecase.dart';
import 'package:silab/features/announcement/presentation/blocs/get_all_announcements/get_all_announcements_bloc.dart';
import 'package:silab/features/announcement/presentation/blocs/get_announcement/get_announcement_bloc.dart';
import 'package:silab/features/classes/domain/entities/class_list_response/classes_response_entity.dart';
import 'package:silab/features/classes/domain/entities/classmates_response/classmates_response_entity.dart';
import 'package:silab/features/classes/domain/entities/meetings_response/meetings_response_entity.dart';
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
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/schedule/domain/entities/practicums/practicums_entity.dart';
import 'package:silab/features/schedule/domain/entities/schedule/schedule_entity.dart';
import 'package:silab/features/schedule/domain/repository/schedule_repository.dart';
import 'package:silab/features/schedule/domain/usecases/get_user_schedule_usecase.dart';
import 'package:silab/features/schedule/presentation/bloc/user_schedule_bloc.dart';
import 'package:silab/features/select_subjects/domain/entities/selected_subject_response/selected_subject_response_entity.dart';
import 'package:silab/features/select_subjects/domain/entities/user_class_option_by_paid_subject_response/user_class_option_by_paid_subject_response_entity.dart';
import 'package:silab/features/select_subjects/domain/repository/selected_subject_repository.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_class_option_by_paid_subject_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_selected_subject_usecase.dart';
import 'package:silab/features/select_subjects/presentation/bloc/selected_subject_by_nim/selected_subject_by_nim_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_event.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_state.dart';
import 'package:silab/features/subjects/domain/entities/subject_list_response/subject_list_response_entity.dart';
import 'package:silab/features/subjects/domain/repository/subject_repository.dart';
import 'package:silab/features/subjects/domain/usecases/get_subject_list_usecase.dart';
import 'package:silab/features/subjects/presentation/bloc/subject_list/subject_list_bloc.dart';
import 'package:silab/features/user_details/domain/entities/assisted_class/assisted_class_entity.dart';
import 'package:silab/features/user_details/domain/entities/user_detail/user_detail_entity.dart';
import 'package:silab/features/user_details/domain/entities/user_detail_response/user_detail_response_entity.dart';
import 'package:silab/features/user_details/domain/repositories/user_repository.dart';
import 'package:silab/features/user_details/domain/usecases/get_assisted_classes_usecase.dart';
import 'package:silab/features/user_details/domain/usecases/get_user_details_usecase.dart';
import 'package:silab/features/user_details/presentation/bloc/assisted_classes/assisted_classes_bloc.dart';
import 'package:silab/features/user_details/presentation/bloc/user_details_bloc.dart';

class FakeRepositories
    implements
        AnnouncementRepository,
        ClassRepository,
        ScheduleRepository,
        SelectedSubjectRepository,
        SubjectRepository,
        UserRepository {
  List<ScheduleEntity> schedule = const [];
  bool down = false;
  Completer<void>? slow;
  final List<String> calls = [];

  Future<Either<Failures, T>> answer<T>(String path, T data) async {
    calls.add(path);
    await slow?.future;
    if (down) return Left(RequestFailures('Tidak dapat terhubung ke server.'));
    return Right(data);
  }

  @override
  Future<Either<Failures, UserDetailResponseEntity>> getUserDetails() => answer(
    '/auth/me',
    const UserDetailResponseEntity(
      data: UserDetailEntity(fullname: 'Budi Santoso'),
    ),
  );

  @override
  Future<Either<Failures, List<AssistedClassEntity>>> getAssistedClasses() =>
      answer('/class', const <AssistedClassEntity>[]);

  @override
  Future<Either<Failures, List<AnnouncementEntity>>> getAllAnnouncement() =>
      answer('/announcement', const <AnnouncementEntity>[]);

  @override
  Future<Either<Failures, AnnouncementEntity>> getAnnouncement({
    String id = '',
  }) => answer('/announcement/$id', AnnouncementEntity(id: id));

  @override
  Future<Either<Failures, ClassesResponseEntity>> getUserRegisteredClasses() =>
      answer('/class/me', const ClassesResponseEntity(data: []));

  @override
  Future<Either<Failures, ClassmatesResponseEntity>> getClassmates({
    String? classId,
  }) => answer(
    '/class/$classId/classmates',
    const ClassmatesResponseEntity(data: []),
  );

  @override
  Future<Either<Failures, MeetingsResponseEntity>> getUserMeetingsData({
    String? classId,
  }) => answer('/meeting/$classId', const MeetingsResponseEntity(data: []));

  @override
  Future<Either<Failures, List<ScheduleEntity>>> getUserSchedule() =>
      answer('/class/me + /class', schedule);

  @override
  Future<Either<Failures, SelectedSubjectResponseEntity>>
  getUserSelectedSubjects() =>
      answer('/activation', const SelectedSubjectResponseEntity(data: []));

  @override
  Future<Either<Failures, UserClassOptionByPaidSubjectResponseEntity>>
  getUserClassOptionbyPaidSubjects() => answer(
    '/class/registration',
    const UserClassOptionByPaidSubjectResponseEntity(data: []),
  );

  @override
  Future<Either<Failures, SubjectListResponseEntity>> getSubjectList() =>
      answer('/subject', const SubjectListResponseEntity(data: []));

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

const everyPageRequest = [
  '/auth/me',
  '/announcement',
  '/class/me',
  '/class/registration',
  '/class/me + /class',
  '/class',
  '/subject',
  '/activation',
  '/class/c1/classmates',
  '/meeting/c1',
  '/announcement/a1',
];

final everyPageFailed = [
  isA<UserDetailFailed>(),
  isA<GetAllAnnouncementsFailed>(),
  isA<UserRegisteredClassFailed>(),
  isA<UserClassOptionByPaidSubjectFailed>(),
  isA<UserScheduleFailed>(),
  isA<AssistedClassesFailed>(),
  isA<SubjectListFailed>(),
  isA<SelectedSubjectByNimFailed>(),
  isA<ClassmatesFailed>(),
  isA<UserMeetingsFailed>(),
  isA<GetAnnouncementFailed>(),
];

final everyPageLoaded = [
  isA<UserDetailLoaded>(),
  isA<GetAllAnnouncementsLoaded>(),
  isA<UserRegisteredClassLoaded>(),
  isA<UserClassOptionByPaidSubjectLoaded>(),
  isA<UserScheduleSuccess>(),
  isA<AssistedClassesLoaded>(),
  isA<SubjectListSuccess>(),
  isA<SelectedSubjectByNimLoaded>(),
  isA<ClassmatesLoaded>(),
  isA<UserMeetingsLoaded>(),
  isA<GetAnnouncementLoaded>(),
];

void main() {
  late BlocObserver previousObserver;
  late EventRecorder recorder;
  late FakeRealtimeRepository realtime;
  late FakeRepositories repositories;

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

  B read<B>(WidgetTester tester) =>
      tester.element(find.byType(SizedBox)).read<B>();

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 3; i++) {
      await tester.pump();
    }
  }

  void openEveryPage(WidgetTester tester) {
    read<UserDetailsBloc>(tester).add(GetUserDetails());
    read<GetAllAnnouncementsBloc>(tester).add(GetAllAnnouncements());
    read<UserRegisteredClassBloc>(tester).add(GetUserRegisteredClass());
    read<UserClassOptionByPaidSubjectBloc>(tester)
        .add(GetUserClassOptionByPaidSubject());
    read<UserScheduleBloc>(tester).add(GetUserSchedule());
    read<AssistedClassesBloc>(tester).add(const GetAssistedClasses());
    read<SubjectListBloc>(tester).add(const GetSubjectList(semester: 1));
    read<SelectedSubjectByNimBloc>(tester).add(GetUserSelectedSubjects());
    read<ClassmatesBloc>(tester).add(const GetClassmates(classId: 'c1'));
    read<UserMeetingsBloc>(tester).add(const GetUserMeetings(classId: 'c1'));
    read<GetAnnouncementBloc>(tester).add(const GetAnnouncement(id: 'a1'));
  }

  List<Object?> pageStates(WidgetTester tester) => [
    read<UserDetailsBloc>(tester).state,
    read<GetAllAnnouncementsBloc>(tester).state,
    read<UserRegisteredClassBloc>(tester).state,
    read<UserClassOptionByPaidSubjectBloc>(tester).state,
    read<UserScheduleBloc>(tester).state,
    read<AssistedClassesBloc>(tester).state,
    read<SubjectListBloc>(tester).state,
    read<SelectedSubjectByNimBloc>(tester).state,
    read<ClassmatesBloc>(tester).state,
    read<UserMeetingsBloc>(tester).state,
    read<GetAnnouncementBloc>(tester).state,
  ];

  Future<void> connect(
    WidgetTester tester, {
    List<ScheduleEntity> schedule = const [],
    bool ready = true,
  }) async {
    repositories = FakeRepositories()..schedule = schedule;

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => RealtimeBloc(WatchRealtimeEventsUsecase(realtime)),
          ),
          BlocProvider(
            create: (_) => UserDetailsBloc(GetUserDetailsUseCase(repositories)),
          ),
          BlocProvider(
            create: (_) =>
                AssistedClassesBloc(GetAssistedClassesUsecase(repositories)),
          ),
          BlocProvider(
            create: (_) => GetAllAnnouncementsBloc(
              GetAllAnnouncementsUseCase(repositories),
            ),
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
              GetSelectedSubjectByNimUsecase(repositories),
            ),
          ),
          BlocProvider(
            create: (_) => UserClassOptionByPaidSubjectBloc(
              GetUserClassOptionByPaidSubjectUsecase(repositories),
            ),
          ),
          BlocProvider(
            create: (_) => UserRegisteredClassBloc(
              GetUserRegisteredClassesUseCase(repositories),
            ),
          ),
          BlocProvider(
            create: (_) =>
                UserScheduleBloc(GetUserScheduleUsecase(repositories)),
          ),
        ],
        child: const RealtimeSync(child: SizedBox()),
      ),
    );

    if (!ready) return;

    await send(tester, const RealtimeEventEntity(type: 'ready'));
    expect(recorder.events, isEmpty);

    if (schedule.isNotEmpty) {
      tester
          .element(find.byType(SizedBox))
          .read<UserScheduleBloc>()
          .add(GetUserSchedule());
      await tester.pump();
      await tester.pump();
      recorder.events.clear();
    }
  }

  testWidgets('semester baru dimulai: semua layar dimuat ulang', (
    tester,
  ) async {
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

  testWidgets(
    'mata kuliah berubah: hanya daftar mata kuliah yang dimuat ulang',
    (tester) async {
      await connect(tester);

      await send(tester, const RealtimeEventEntity(type: 'subject'));

      expect(recorder.events, [isA<RefreshSubjectList>()]);
    },
  );

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
    },
  );

  testWidgets('asisten kelas berubah: pengumuman ikut dimuat ulang', (
    tester,
  ) async {
    await connect(tester);

    await send(
      tester,
      const RealtimeEventEntity(
        type: 'class',
        action: 'assistants',
        classId: 'c1',
      ),
    );

    expect(recorder.events, contains(isA<RefreshAllAnnouncements>()));
  });

  testWidgets('kelas biasa berubah: pengumuman tidak dimuat ulang', (
    tester,
  ) async {
    await connect(tester);

    await send(
      tester,
      const RealtimeEventEntity(
        type: 'class',
        action: 'updated',
        classId: 'c1',
      ),
    );

    expect(recorder.events, isNot(contains(isA<RefreshAllAnnouncements>())));
    expect(
      recorder.events,
      isNot(contains(isA<RefreshUserSelectedSubjects>())),
    );
  });

  testWidgets(
    'kelas baru dibuat: baris Kelas di Pembayaran & Kelas ikut dimuat ulang',
    (tester) async {
      await connect(tester);

      await send(
        tester,
        const RealtimeEventEntity(
          type: 'class',
          action: 'created',
          classId: 'c2',
        ),
      );

      expect(
        recorder.events,
        containsAll([
          isA<RefreshUserClassOptionByPaidSubject>(),
          isA<RefreshUserSelectedSubjects>(),
        ]),
      );
    },
  );

  testWidgets('asisten kelas berubah: Jadwal ikut dimuat ulang', (
    tester,
  ) async {
    await connect(tester);

    await send(
      tester,
      const RealtimeEventEntity(
        type: 'class',
        action: 'assistants',
        classId: 'c1',
      ),
    );

    expect(recorder.events, contains(isA<RefreshUserSchedule>()));
  });

  testWidgets(
    'kelas yang tampil di Jadwal berubah: Jadwal dimuat ulang, kelas lain tidak',
    (tester) async {
      await connect(
        tester,
        schedule: const [
          ScheduleEntity(
            day: 'Senin',
            practicums: [
              PracticumsEntity(classId: 'c-asisten', isAssistant: true),
            ],
          ),
        ],
      );

      await send(
        tester,
        const RealtimeEventEntity(type: 'class', classId: 'c-lain'),
      );
      expect(recorder.events, isNot(contains(isA<RefreshUserSchedule>())));

      await send(
        tester,
        const RealtimeEventEntity(type: 'class', classId: 'c-asisten'),
      );
      expect(recorder.events, contains(isA<RefreshUserSchedule>()));
    },
  );

  testWidgets(
    'aplikasi dibuka saat server mati: begitu tersambung, semua yang gagal dimuat ulang sendiri',
    (tester) async {
      await connect(tester, ready: false);
      repositories.down = true;
      openEveryPage(tester);
      await settle(tester);
      expect(pageStates(tester), everyPageFailed);

      repositories
        ..down = false
        ..calls.clear();
      await send(tester, const RealtimeEventEntity(type: 'ready'));
      await settle(tester);

      expect(repositories.calls, unorderedEquals(everyPageRequest));
      expect(pageStates(tester), everyPageLoaded);
    },
  );

  testWidgets(
    'dibuka normal, data masih dimuat: koneksi pertama tidak meminta data lagi',
    (tester) async {
      await connect(tester, ready: false);
      repositories.slow = Completer<void>();
      openEveryPage(tester);
      await settle(tester);
      recorder.events.clear();

      await send(tester, const RealtimeEventEntity(type: 'ready'));
      expect(recorder.events, isEmpty);

      repositories.slow!.complete();
      await settle(tester);

      expect(repositories.calls, unorderedEquals(everyPageRequest));
      expect(pageStates(tester), everyPageLoaded);
    },
  );

  testWidgets(
    'dibuka normal, data sudah tampil: koneksi pertama tidak meminta data lagi',
    (tester) async {
      await connect(tester, ready: false);
      openEveryPage(tester);
      await settle(tester);
      recorder.events.clear();
      repositories.calls.clear();

      await send(tester, const RealtimeEventEntity(type: 'ready'));
      await settle(tester);

      expect(recorder.events, isEmpty);
      expect(repositories.calls, isEmpty);
    },
  );

  testWidgets('koneksi pertama hanya memuat ulang bagian yang gagal', (
    tester,
  ) async {
    await connect(tester, ready: false);
    openEveryPage(tester);
    await settle(tester);

    repositories.down = true;
    read<UserDetailsBloc>(tester).add(GetUserDetails());
    read<UserScheduleBloc>(tester).add(GetUserSchedule());
    await settle(tester);

    repositories
      ..down = false
      ..calls.clear();
    await send(tester, const RealtimeEventEntity(type: 'ready'));
    await settle(tester);

    expect(
      repositories.calls,
      unorderedEquals(['/auth/me', '/class/me + /class']),
    );
    expect(pageStates(tester), everyPageLoaded);
  });

  testWidgets(
    'tersambung ulang: nama dan detail pengumuman yang gagal ikut dimuat ulang',
    (tester) async {
      await connect(tester);
      repositories.down = true;
      read<UserDetailsBloc>(tester).add(GetUserDetails());
      read<GetAnnouncementBloc>(tester).add(const GetAnnouncement(id: 'a1'));
      await settle(tester);

      repositories
        ..down = false
        ..calls.clear();
      await send(tester, const RealtimeEventEntity(type: 'ready'));
      await settle(tester);

      expect(
        repositories.calls,
        unorderedEquals(['/auth/me', '/announcement/a1']),
      );
      expect(read<UserDetailsBloc>(tester).state, isA<UserDetailLoaded>());
      expect(
        read<GetAnnouncementBloc>(tester).state,
        isA<GetAnnouncementLoaded>(),
      );
    },
  );

  testWidgets(
    'tersambung ulang: nama dan detail pengumuman yang tampil tidak diminta ulang',
    (tester) async {
      await connect(tester);
      read<UserDetailsBloc>(tester).add(GetUserDetails());
      read<GetAnnouncementBloc>(tester).add(const GetAnnouncement(id: 'a1'));
      await settle(tester);
      repositories.calls.clear();

      await send(tester, const RealtimeEventEntity(type: 'ready'));
      await settle(tester);

      expect(repositories.calls, isEmpty);
    },
  );
}
