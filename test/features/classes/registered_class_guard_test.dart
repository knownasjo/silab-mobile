import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/common/entities/class/class_entity.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/classes/data/data_sources/classes_api_service.dart';
import 'package:silab/features/classes/data/repository/class_repository_impl.dart';
import 'package:silab/features/classes/domain/usecases/get_user_registered_classes_usecase.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';
import 'package:silab/features/classes/presentation/widgets/registered_class_guard.dart';

const alproC = {
  'id': 'c-alpro',
  'subject_id': 's1',
  'subject_name': 'Algoritma dan Pemrograman',
  'subject_class': 'C',
  'semester': '1',
  'lecturer': 'Dosen001',
  'day': 'TUESDAY',
  'session_time': '16.10 - 17.10',
  'room': 'PSI',
};

const openedFromList = ClassEntity(
  id: 'c-alpro',
  subject_name: 'Algoritma dan Pemrograman',
  subject_class: 'C',
  day: 'TUESDAY',
  lecturer: 'Dosen001',
  session_time: '16.10 - 17.10',
);

void main() {
  late SharedPreferences prefs;
  late List<Map<String, Object>> classes;
  late int statusCode;

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({'accessToken': 'token'});
    prefs = await SharedPreferences.getInstance();
    classes = [alproC];
    statusCode = 200;
  });

  UserRegisteredClassBloc createBloc() {
    final api = ApiClient(
      MockClient((request) async {
        expect(request.url.path, '/class/me');
        return statusCode == 200
            ? http.Response(
                jsonEncode(
                    {'status': true, 'message': 'Berhasil', 'data': classes}),
                200,
              )
            : http.Response(
                jsonEncode({'status': false, 'message': 'Server bermasalah'}),
                statusCode,
              );
      }),
      prefs,
    );

    return UserRegisteredClassBloc(
      GetUserRegisteredClassesUseCase(
        ClassRepositoryImpl(ClassesApiService(api)),
      ),
    );
  }

  Future<void> settle() =>
      Future<void>.delayed(const Duration(milliseconds: 30));

  Widget app(UserRegisteredClassBloc bloc) => BlocProvider.value(
        value: bloc,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/class',
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const Text('Halaman Beranda'),
              ),
              GoRoute(
                path: '/class',
                builder: (context, state) => Scaffold(
                  body: RegisteredClassGuard(
                    classEntity: openedFromList,
                    builder: (context, latest) => Text(
                      'Kelas ${latest.subject_class} · ${latest.day} · ${latest.session_time}',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  testWidgets(
      'sebelum daftar kelas dimuat, memakai data dari halaman sebelumnya',
      (tester) async {
    final bloc = createBloc();

    await tester.pumpWidget(app(bloc));

    expect(find.text('Kelas C · TUESDAY · 16.10 - 17.10'), findsOne);
    await tester.runAsync(() => bloc.close());
  });

  testWidgets('jadwal yang diubah laboran langsung tampil', (tester) async {
    late UserRegisteredClassBloc bloc;

    await tester.runAsync(() async {
      bloc = createBloc()..add(GetUserRegisteredClass());
      await settle();
    });
    await tester.pumpWidget(app(bloc));
    expect(find.text('Kelas C · TUESDAY · 16.10 - 17.10'), findsOne);

    classes = [
      {
        ...alproC,
        'subject_class': 'E',
        'day': 'WEDNESDAY',
        'session_time': '12.30 - 14.10'
      },
    ];
    await tester.runAsync(() async {
      bloc.add(RefreshUserRegisteredClass());
      await settle();
    });
    await tester.pump();

    expect(find.text('Kelas E · WEDNESDAY · 12.30 - 14.10'), findsOne);
    expect(find.text('Anda sudah tidak terdaftar di kelas ini.'), findsNothing);
    await tester.runAsync(() => bloc.close());
  });

  testWidgets('kelas dihapus: tampil pemberitahuan dan tombol ke Beranda',
      (tester) async {
    late UserRegisteredClassBloc bloc;

    await tester.runAsync(() async {
      bloc = createBloc()..add(GetUserRegisteredClass());
      await settle();
    });
    await tester.pumpWidget(app(bloc));

    classes = [];
    await tester.runAsync(() async {
      bloc.add(RefreshUserRegisteredClass());
      await settle();
    });
    await tester.pump();

    expect(find.text('Kelas C · TUESDAY · 16.10 - 17.10'), findsNothing);
    expect(find.text('Anda sudah tidak terdaftar di kelas ini.'), findsOne);

    await tester.tap(find.text('Kembali ke Beranda'));
    await tester.pumpAndSettle();

    expect(find.text('Halaman Beranda'), findsOne);
    await tester.runAsync(() => bloc.close());
  });

  testWidgets('refresh gagal tidak dianggap kelas dihapus', (tester) async {
    late UserRegisteredClassBloc bloc;

    await tester.runAsync(() async {
      bloc = createBloc()..add(GetUserRegisteredClass());
      await settle();
    });
    await tester.pumpWidget(app(bloc));

    statusCode = 500;
    await tester.runAsync(() async {
      bloc.add(RefreshUserRegisteredClass());
      await settle();
    });
    await tester.pump();

    expect(find.text('Kelas C · TUESDAY · 16.10 - 17.10'), findsOne);
    expect(find.text('Anda sudah tidak terdaftar di kelas ini.'), findsNothing);
    await tester.runAsync(() => bloc.close());
  });
}
