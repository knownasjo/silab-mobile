import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silab/core/common/entities/class/class_entity.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/announcement/domain/entities/announcement/announcement_entity.dart';
import 'package:silab/features/announcement/domain/repository/announcement_repository.dart';
import 'package:silab/features/announcement/domain/usecases/get_announcement_usecase.dart';
import 'package:silab/features/announcement/presentation/blocs/get_announcement/get_announcement_bloc.dart';
import 'package:silab/features/classes/domain/entities/class_list_response/classes_response_entity.dart';
import 'package:silab/features/classes/domain/entities/meetings/meetings_entity.dart';
import 'package:silab/features/classes/domain/entities/meetings_response/meetings_response_entity.dart';
import 'package:silab/features/classes/domain/repository/class_repository.dart';
import 'package:silab/features/classes/domain/usecases/get_user_meetings_data_usecase.dart';
import 'package:silab/features/classes/domain/usecases/get_user_registered_classes_usecase.dart';
import 'package:silab/features/classes/presentation/bloc/user_meetings/user_meetings_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';

class FakeClassRepository implements ClassRepository {
  final List<String> calls = [];
  List<ClassEntity> classes = [];
  Map<String, List<MeetingsEntity>> meetings = {};
  bool fail = false;

  @override
  Future<Either<Failures, ClassesResponseEntity>>
      getUserRegisteredClasses() async {
    calls.add('/class/me');
    if (fail) return Left(RequestFailures('Server tidak merespons.'));
    return Right(ClassesResponseEntity(data: List.of(classes)));
  }

  @override
  Future<Either<Failures, MeetingsResponseEntity>> getUserMeetingsData(
      {String? classId}) async {
    calls.add('/meeting/$classId');
    return Right(MeetingsResponseEntity(data: meetings[classId] ?? const []));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeAnnouncementRepository implements AnnouncementRepository {
  final List<String> calls = [];
  Map<String, AnnouncementEntity> announcements = {};

  @override
  Future<Either<Failures, AnnouncementEntity>> getAnnouncement(
      {String id = ''}) async {
    calls.add('/announcement/$id');
    final announcement = announcements[id];
    return announcement == null
        ? Left(RequestFailures('Pengumuman tidak ditemukan!'))
        : Right(announcement);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 10));

void main() {
  group('kelas terdaftar', () {
    late FakeClassRepository repository;
    late UserRegisteredClassBloc bloc;
    late List<UserRegisteredClassState> states;

    setUp(() {
      repository = FakeClassRepository();
      bloc =
          UserRegisteredClassBloc(GetUserRegisteredClassesUseCase(repository));
      states = [];
      bloc.stream.listen(states.add);
    });

    tearDown(() => bloc.close());

    test('belum pernah dimuat: event real-time tidak memicu permintaan',
        () async {
      bloc.add(RefreshUserRegisteredClass());
      await settle();

      expect(repository.calls, isEmpty);
      expect(states, isEmpty);
    });

    test('kelas baru muncul tanpa state loading', () async {
      repository.classes = [const ClassEntity(id: 'c1')];
      bloc.add(GetUserRegisteredClass());
      await settle();
      states.clear();

      repository.classes = [
        const ClassEntity(id: 'c1'),
        const ClassEntity(id: 'c2'),
      ];
      bloc.add(RefreshUserRegisteredClass());
      await settle();

      expect(states, hasLength(1));
      expect(states.single, isA<UserRegisteredClassLoaded>());
      expect(states.single.registeredClasses?.map((c) => c.id), ['c1', 'c2']);
    });

    test('gagal memuat ulang: data lama tetap tampil', () async {
      repository.classes = [const ClassEntity(id: 'c1')];
      bloc.add(GetUserRegisteredClass());
      await settle();
      states.clear();

      repository.fail = true;
      bloc.add(RefreshUserRegisteredClass());
      await settle();

      expect(states, isEmpty);
      expect(bloc.state.registeredClasses?.single.id, 'c1');
    });
  });

  group('pertemuan', () {
    test('event dari kelas lain diabaikan', () async {
      final repository = FakeClassRepository()
        ..meetings = {
          'c1': [const MeetingsEntity(id: 'm1', is_open: false)],
        };
      final bloc = UserMeetingsBloc(GetUserMeetingsDataUsecase(repository));
      bloc.add(const GetUserMeetings(classId: 'c1'));
      await settle();
      repository.calls.clear();

      bloc.add(const RefreshUserMeetings(classId: 'c2'));
      await settle();
      expect(repository.calls, isEmpty);

      repository.meetings = {
        'c1': [const MeetingsEntity(id: 'm1', is_open: true)],
      };
      bloc.add(const RefreshUserMeetings());
      await settle();

      expect(repository.calls, ['/meeting/c1']);
      expect(bloc.state.meetingsData?.single.is_open, isTrue);
      await bloc.close();
    });
  });

  group('detail pengumuman', () {
    late FakeAnnouncementRepository repository;
    late GetAnnouncementBloc bloc;

    setUp(() async {
      repository = FakeAnnouncementRepository()
        ..announcements = {
          'a1': const AnnouncementEntity(id: 'a1', title: 'Lama'),
        };
      bloc = GetAnnouncementBloc(GetAnnouncementUseCase(repository));
      bloc.add(const GetAnnouncement(id: 'a1'));
      await settle();
      repository.calls.clear();
    });

    tearDown(() => bloc.close());

    test('pengumuman lain yang berubah tidak memicu permintaan', () async {
      bloc.add(const RefreshAnnouncement(id: 'a2'));
      await settle();

      expect(repository.calls, isEmpty);
    });

    test('isi yang diubah laboran langsung tampil', () async {
      repository.announcements['a1'] =
          const AnnouncementEntity(id: 'a1', title: 'Baru');
      bloc.add(const RefreshAnnouncement(id: 'a1'));
      await settle();

      expect(bloc.state.announcement?.title, 'Baru');
    });

    test('pengumuman yang dihapus membuat halaman ditutup', () async {
      bloc.add(const RefreshAnnouncement(id: 'a1', isDeleted: true));
      await settle();

      expect(bloc.state, isA<GetAnnouncementDeleted>());
      expect(bloc.state.message, 'Pengumuman ini sudah dihapus.');
      expect(repository.calls, isEmpty);
    });
  });
}
