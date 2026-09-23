import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:silab/features/realtime/domain/entities/realtime_event_entity.dart';
import 'package:silab/features/realtime/domain/repository/realtime_repository.dart';
import 'package:silab/features/realtime/domain/usecases/watch_realtime_events_usecase.dart';
import 'package:silab/features/realtime/presentation/bloc/realtime_bloc.dart';

class FakeRealtimeRepository implements RealtimeRepository {
  final List<StreamController<RealtimeEventEntity>> connections = [];

  StreamController<RealtimeEventEntity> get current => connections.last;

  @override
  Stream<RealtimeEventEntity> watchEvents() {
    final controller = StreamController<RealtimeEventEntity>();
    connections.add(controller);
    return controller.stream;
  }
}

Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 10));

void main() {
  late FakeRealtimeRepository repository;
  late RealtimeBloc bloc;
  late List<RealtimeState> states;

  setUp(() {
    repository = FakeRealtimeRepository();
    bloc = RealtimeBloc(WatchRealtimeEventsUsecase(repository));
    states = [];
    bloc.stream.listen(states.add);
  });

  tearDown(() => bloc.close());

  Iterable<String?> receivedTypes() =>
      states.whereType<RealtimeMessage>().map((state) => state.message?.type);

  test('ready pertama diabaikan karena halaman baru saja memuat data',
      () async {
    bloc.add(const StartRealtime());
    await settle();

    repository.current
      ..add(const RealtimeEventEntity(type: 'ready'))
      ..add(const RealtimeEventEntity(type: 'meeting', classId: 'c1'));
    await settle();

    expect(receivedTypes(), ['meeting']);
    expect(
      (states.last as RealtimeMessage).message,
      const RealtimeEventEntity(type: 'meeting', classId: 'c1'),
    );
  });

  test('ready setelah tersambung ulang diteruskan agar data disusul', () async {
    bloc.add(const StartRealtime());
    await settle();
    repository.current.add(const RealtimeEventEntity(type: 'ready'));
    await settle();

    bloc.add(const StartRealtime());
    await settle();
    repository.current.add(const RealtimeEventEntity(type: 'ready'));
    await settle();

    expect(repository.connections, hasLength(2));
    expect(receivedTypes(), ['ready']);
  });

  test('event yang sama berturut-turut tetap diteruskan semuanya', () async {
    bloc.add(const StartRealtime());
    await settle();

    for (var i = 0; i < 3; i++) {
      repository.current.add(const RealtimeEventEntity(type: 'activation'));
    }
    await settle();

    expect(receivedTypes(), ['activation', 'activation', 'activation']);
  });

  test('dibuka ulang: langganan lama ditutup', () async {
    bloc.add(const StartRealtime());
    await settle();
    final first = repository.current;

    bloc.add(const StartRealtime());
    await settle();

    expect(first.hasListener, isFalse);
    expect(repository.current.hasListener, isTrue);
  });

  test('StopRealtime menutup langganan; login berikutnya mulai dari awal',
      () async {
    bloc.add(const StartRealtime());
    await settle();
    repository.current.add(const RealtimeEventEntity(type: 'ready'));
    await settle();

    bloc.add(const StopRealtime());
    await settle();
    expect(repository.current.hasListener, isFalse);
    expect(bloc.state, isA<RealtimeIdle>());

    bloc.add(const StartRealtime());
    await settle();
    repository.current.add(const RealtimeEventEntity(type: 'ready'));
    await settle();

    expect(receivedTypes(), isEmpty);
  });

  test('isi event dibaca dari JSON backend', () {
    expect(
      RealtimeEventEntity.fromJson('announcement', const {
        'announcement_id': 'a1',
        'action': 'deleted',
        'class_id': 7,
      }),
      const RealtimeEventEntity(
        type: 'announcement',
        announcementId: 'a1',
        action: 'deleted',
      ),
    );
  });
}
