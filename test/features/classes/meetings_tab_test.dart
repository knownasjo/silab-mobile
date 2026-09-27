import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silab/core/common/widgets/custom_loading_indicator.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/classes/domain/entities/meetings/meetings_entity.dart';
import 'package:silab/features/classes/domain/entities/meetings_response/meetings_response_entity.dart';
import 'package:silab/features/classes/domain/repository/class_repository.dart';
import 'package:silab/features/classes/domain/usecases/get_user_meetings_data_usecase.dart';
import 'package:silab/features/classes/presentation/bloc/user_meetings/user_meetings_bloc.dart';
import 'package:silab/features/classes/presentation/widgets/class_details_tabview.dart';

class PendingMeetingsRepository implements ClassRepository {
  final response = Completer<Either<Failures, MeetingsResponseEntity>>();

  @override
  Future<Either<Failures, MeetingsResponseEntity>> getUserMeetingsData(
          {String? classId}) =>
      response.future;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late PendingMeetingsRepository repository;

  Future<UserMeetingsBloc> openTab(WidgetTester tester) async {
    repository = PendingMeetingsRepository();
    late UserMeetingsBloc bloc;

    await tester.runAsync(() async {
      bloc = UserMeetingsBloc(GetUserMeetingsDataUsecase(repository))
        ..add(const GetUserMeetings(classId: 'c1'));
      await Future<void>.delayed(const Duration(milliseconds: 10));
    });
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BlocProvider.value(
          value: bloc,
          child: const ClassDetailTabView(classId: 'c1'),
        ),
      ),
    ));

    return bloc;
  }

  Future<void> respond(WidgetTester tester,
      Either<Failures, MeetingsResponseEntity> response) async {
    await tester.runAsync(() async {
      repository.response.complete(response);
      await Future<void>.delayed(const Duration(milliseconds: 10));
    });
    await tester.pump();
  }

  testWidgets('sedang memuat: tab Presensi menampilkan loading',
      (tester) async {
    final bloc = await openTab(tester);

    expect(find.byType(CustomLoadingIndicator), findsOneWidget);
    await tester.runAsync(() => bloc.close());
  });

  testWidgets('gagal memuat: tab Presensi menampilkan pesan dari server',
      (tester) async {
    final bloc = await openTab(tester);

    await respond(
        tester,
        Left(RequestFailures(
            'Server sedang sibuk, silakan coba lagi sebentar lagi.')));

    expect(find.byType(CustomLoadingIndicator), findsNothing);
    expect(
      find.text('Server sedang sibuk, silakan coba lagi sebentar lagi.'),
      findsOneWidget,
    );
    await tester.runAsync(() => bloc.close());
  });

  testWidgets('belum ada pertemuan: tab Presensi memberi keterangan',
      (tester) async {
    final bloc = await openTab(tester);

    await respond(tester, const Right(MeetingsResponseEntity(data: [])));

    expect(find.text('Belum ada pertemuan di kelas ini.'), findsOneWidget);
    await tester.runAsync(() => bloc.close());
  });

  testWidgets('ada pertemuan: daftar tampil, yang terbaru di atas',
      (tester) async {
    final bloc = await openTab(tester);

    await respond(
        tester,
        const Right(MeetingsResponseEntity(data: [
          MeetingsEntity(id: 'm1', meeting_name: 'Pertemuan 1'),
          MeetingsEntity(id: 'm2', meeting_name: 'Pertemuan 2'),
        ])));

    final newest = tester.getTopLeft(find.text('Pertemuan 2')).dy;
    final oldest = tester.getTopLeft(find.text('Pertemuan 1')).dy;
    expect(newest, lessThan(oldest));
    await tester.runAsync(() => bloc.close());
  });
}
