import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/announcement/domain/entities/announcement/announcement_entity.dart';
import 'package:silab/features/announcement/domain/repository/announcement_repository.dart';
import 'package:silab/features/announcement/domain/usecases/get_announcement_usecase.dart';
import 'package:silab/features/announcement/presentation/blocs/get_announcement/get_announcement_bloc.dart';
import 'package:silab/features/announcement/presentation/pages/pengumumman_page.dart';

class FakeAnnouncementRepository implements AnnouncementRepository {
  final AnnouncementEntity announcement;

  FakeAnnouncementRepository(this.announcement);

  @override
  Future<Either<Failures, AnnouncementEntity>> getAnnouncement(
          {String id = ''}) async =>
      Right(announcement);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('pengumuman 1000 karakter bisa digulir sampai akhir di HP kecil',
      (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final body = [
      'Paragraf pertama ${'kata ' * 60}',
      'Paragraf kedua ${'kata ' * 60}',
      'Paragraf ketiga ${'kata ' * 60}',
      'Bagian akhir pengumuman.',
    ].join('\n\n');
    expect(body.length, lessThanOrEqualTo(1000));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => GetAnnouncementBloc(
            GetAnnouncementUseCase(
              FakeAnnouncementRepository(
                AnnouncementEntity(
                  id: 'a1',
                  title: 'Pengumuman Panjang',
                  type: 'BASIC',
                  body: body,
                  created_at: DateTime.now().toIso8601String(),
                  author: 'Laboran',
                ),
              ),
            ),
          ),
          child: const PengumumanPage(id: 'a1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.textContaining('Paragraf pertama'), findsOneWidget);

    await tester.dragUntilVisible(
      find.textContaining('Bagian akhir pengumuman.'),
      find.byType(SingleChildScrollView),
      const Offset(0, -200),
    );
    expect(tester.takeException(), isNull);
  });
}
