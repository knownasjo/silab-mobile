import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/user_details/data/data_sources/user_api_service.dart';
import 'package:silab/features/user_details/data/repositories/user_repository_impl.dart';
import 'package:silab/features/user_details/domain/entities/assisted_class/assisted_class_entity.dart';
import 'package:silab/features/user_details/domain/usecases/get_assisted_classes_usecase.dart';
import 'package:silab/features/user_details/presentation/bloc/assisted_classes/assisted_classes_bloc.dart';
import 'package:silab/features/user_details/presentation/widgets/assisted_classes_section.dart';

const alproB = {
  'id': 'b8dca325',
  'subjectId': 's1',
  'name': 'B',
  'subject_name': 'Algoritma dan Pemrograman',
  'semester': '1',
  'quota': 30,
  'isFull': false,
  'room': 'PSI',
  'day': 'MONDAY',
  'startAt': '07.00',
  'endAt': '08.40',
  'participants': 3,
};

const rplA = {
  'id': 'eb4e960d',
  'name': 'A',
  'subject_name': 'Rekayasa Perangkat Lunak',
  'day': 'TUESDAY',
  'startAt': '09.00',
  'endAt': '10.40',
  'room': 'SBTI',
};

void main() {
  late SharedPreferences prefs;
  late List<Map<String, Object>> classes;
  late int statusCode;
  late int requestCount;

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({'accessToken': 'token'});
    prefs = await SharedPreferences.getInstance();
    classes = [alproB];
    statusCode = 200;
    requestCount = 0;
  });

  AssistedClassesBloc createBloc() {
    final api = ApiClient(
      MockClient((request) async {
        requestCount++;
        expect(request.url.path, '/class');
        return statusCode == 200
            ? http.Response(
                jsonEncode({'status': true, 'data': classes}),
                200,
              )
            : http.Response(
                jsonEncode({'status': false, 'message': 'Server bermasalah'}),
                statusCode,
              );
      }),
      prefs,
    );

    return AssistedClassesBloc(
      GetAssistedClassesUsecase(UserRepositoryImpl(UserApiService(api))),
    );
  }

  Future<void> settle() =>
      Future<void>.delayed(const Duration(milliseconds: 30));

  test('kelas asisten dibaca dari respons GET /class', () {
    expect(
      AssistedClassEntity.fromJson(alproB),
      const AssistedClassEntity(
        id: 'b8dca325',
        name: 'B',
        subjectName: 'Algoritma dan Pemrograman',
        day: 'MONDAY',
        startAt: '07.00',
        endAt: '08.40',
        room: 'PSI',
      ),
    );
  });

  test('dimuat: Loading lalu Loaded', () async {
    final bloc = createBloc();
    final states = <AssistedClassesState>[];
    final subscription = bloc.stream.listen(states.add);

    bloc.add(const GetAssistedClasses());
    await settle();

    expect(states, [
      const AssistedClassesLoading(),
      AssistedClassesLoaded([AssistedClassEntity.fromJson(alproB)]),
    ]);
    await subscription.cancel();
    await bloc.close();
  });

  test('refresh diabaikan bila Profil belum pernah dibuka', () async {
    final bloc = createBloc();

    bloc.add(const RefreshAssistedClasses());
    await settle();

    expect(requestCount, 0);
    expect(bloc.state, const AssistedClassesInitial());
    await bloc.close();
  });

  test('refresh: kelas baru muncul tanpa Loading, gagal tidak menghapus data',
      () async {
    final bloc = createBloc();
    bloc.add(const GetAssistedClasses());
    await settle();

    final states = <AssistedClassesState>[];
    final subscription = bloc.stream.listen(states.add);

    classes = [alproB, rplA];
    bloc.add(const RefreshAssistedClasses());
    await settle();

    statusCode = 500;
    bloc.add(const RefreshAssistedClasses());
    await settle();

    expect(states, [
      AssistedClassesLoaded([
        AssistedClassEntity.fromJson(alproB),
        AssistedClassEntity.fromJson(rplA),
      ]),
    ]);
    expect(bloc.state, isA<AssistedClassesLoaded>());
    await subscription.cancel();
    await bloc.close();
  });

  testWidgets('bagian Asisten Praktikum hanya tampil bila memegang kelas',
      (tester) async {
    late AssistedClassesBloc bloc;

    classes = [];
    await tester.runAsync(() async {
      bloc = createBloc()..add(const GetAssistedClasses());
      await settle();
    });
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: bloc,
            child: const AssistedClassesSection(),
          ),
        ),
      ),
    );
    expect(find.text('Asisten Praktikum'), findsNothing);

    classes = [alproB];
    await tester.runAsync(() async {
      bloc.add(const RefreshAssistedClasses());
      await settle();
    });
    await tester.pump();

    expect(find.text('Asisten Praktikum'), findsOne);
    expect(find.text('Algoritma dan Pemrograman — Kelas B'), findsOne);
    expect(find.text('Senin · 07.00 - 08.40 · PSI'), findsOne);
    expect(find.text('Kelola kelas lewat web SILAB.'), findsOne);

    await tester.runAsync(() => bloc.close());
  });
}
