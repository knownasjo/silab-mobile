import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/select_subjects/data/data_sources/selected_subject_api_service.dart';
import 'package:silab/features/select_subjects/data/repository/selected_subject_repository_impl.dart';
import 'package:silab/features/select_subjects/domain/usecases/add_selected_class_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/cancel_activation_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_class_option_by_paid_subject_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_selected_subject_usecase.dart';
import 'package:silab/features/select_subjects/presentation/bloc/add_selected_class/add_selected_class_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/cancel_activation/cancel_activation_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/selected_subject_by_nim/selected_subject_by_nim_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/pages/daftar_praktikum_page.dart';
import 'package:silab/features/select_subjects/presentation/pages/payment_status_page.dart';
import 'package:silab/features/select_subjects/presentation/pages/pilih_kelas_page.dart';
import 'package:silab/features/subjects/data/data_sources/subject_api_service.dart';
import 'package:silab/features/subjects/data/repository/subject_repository_impl.dart';
import 'package:silab/features/subjects/domain/usecases/get_subject_list_usecase.dart';
import 'package:silab/features/subjects/presentation/bloc/subject_list/subject_list_bloc.dart';

import '../../helpers/real_font.dart';
import '../../helpers/small_phone_shell.dart';

const days = ['MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY'];

void main() {
  late SharedPreferences prefs;
  late int count;

  setUpAll(loadRealFont);

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues(
        {'accessToken': 'akses', 'refreshToken': 'segar'});
    prefs = await SharedPreferences.getInstance();
  });

  http.Response ok(Object? data) => http.Response(
      jsonEncode({'status': true, 'message': 'Berhasil', 'data': data}), 200);

  Future<http.Response> backend(http.Request request) async {
    final items = List.generate(count, (i) => i + 1);

    return switch (request.url.path) {
      '/class/registration' => ok([
          for (final i in items)
            {
              'id': 'k$i',
              'subject_name': 'Basis Data',
              'subject_class': String.fromCharCode(64 + i),
              'semester': '3',
              'session_time': '07.00 - 08.40',
              'quota': 30,
              'registered_students': 5,
              'day': days[i - 1],
            }
        ]),
      '/subject' => ok([
          for (final i in items)
            {
              'id': 's$i',
              'subject_name': 'Praktikum Mata Kuliah $i',
              'subject_code': '55331000$i',
              'semester': '1',
            }
        ]),
      '/activation' => ok([
          for (final i in items)
            {
              'id': 'a$i',
              'status': true,
              'created_at': '2026-09-30T02:00:00.000Z',
              'subject_id': 's$i',
              'subjects': [
                {'subject_name': 'Mata Kuliah $i', 'semester': '3'}
              ],
              'registered_class': {'id': 'k$i', 'name': 'A'},
              'available_classes': [
                {
                  'id': 'k$i',
                  'name': 'A',
                  'day': 'MONDAY',
                  'session_time': '07.00 - 08.40',
                  'room': 'Lab',
                  'quota': 30,
                  'registered_students': 5,
                  'is_full': false,
                }
              ],
            }
        ]),
      _ => http.Response('{"status":false,"message":"Not Found"}', 404),
    };
  }

  Future<void> openPage(WidgetTester tester, String location) async {
    useSmallPhone(tester);

    final api = ApiClient(MockClient(backend), prefs);
    final subjects =
        SelectedSubjectRepositoryImpl(SelectedSubjectApiService(api));
    final controller = ScrollController();
    addTearDown(controller.dispose);

    final router = GoRouter(initialLocation: location, routes: [
      ShellRoute(
        builder: (context, state, child) => shellWithNavbar(
          title: 'Halaman',
          controller: controller,
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/home',
            builder: (_, __) => const SizedBox(),
            routes: [
              GoRoute(
                path: 'pilih-kelas',
                builder: (_, __) => const PilihKelasPage(),
              ),
              GoRoute(
                path: 'daftar-praktikum',
                builder: (_, __) => const DaftarPraktikumPage(),
              ),
              GoRoute(
                path: 'payment-status',
                builder: (_, __) => BlocProvider(
                  create: (_) =>
                      CancelActivationBloc(CancelActivationUsecase(subjects)),
                  child: const PaymentStatusPage(),
                ),
              ),
            ],
          ),
        ],
      ),
    ]);
    addTearDown(router.dispose);

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserClassOptionByPaidSubjectBloc(
              GetUserClassOptionByPaidSubjectUsecase(subjects)),
        ),
        BlocProvider(
          create: (_) =>
              AddSelectedClassBloc(AddSelectedClassUseCase(subjects)),
        ),
        BlocProvider(
          create: (_) => SelectedSubjectByNimBloc(
              GetSelectedSubjectByNimUsecase(subjects)),
        ),
        BlocProvider(
          create: (_) => SubjectListBloc(GetSubjectListUseCase(
              SubjectRepositoryImpl(SubjectApiService(api)))),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(fontFamily: realFontFamily),
        routerConfig: router,
      ),
    ));
    for (var i = 0; i < 5; i++) {
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)));
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pumpAndSettle();
  }

  Future<void> expectButtonAboveNavbar(
      WidgetTester tester, String label) async {
    final button = find.widgetWithText(ElevatedButton, label);
    expect(button, findsOneWidget);

    await scrollEverythingToEnd(tester);

    expect(tester.takeException(), isNull);
    expect(
      tester.getRect(button).bottom,
      lessThanOrEqualTo(navbarTop(tester)),
      reason: 'tombol $label tertutup menu bawah',
    );
  }

  for (final classes in [3, 4, 5, 6]) {
    testWidgets(
        'Pilih Kelas, $classes kelas: tombol Simpan bisa dicapai di atas menu bawah',
        (tester) async {
      count = classes;
      await openPage(tester, '/home/pilih-kelas');
      await tester.tap(find.text('Senin, 07.00 - 08.40'));
      await tester.pumpAndSettle();
      await expectButtonAboveNavbar(tester, 'Simpan');
    });
  }

  for (final subjects in [3, 4, 5, 6]) {
    testWidgets(
        'Pendaftaran Praktikum, $subjects mata kuliah: tombol Selanjutnya bisa dicapai di atas menu bawah',
        (tester) async {
      count = subjects;
      await openPage(tester, '/home/daftar-praktikum');
      await expectButtonAboveNavbar(tester, 'Selanjutnya');
    });
  }

  for (final activations in [2, 3, 4]) {
    testWidgets(
        'Pembayaran & Kelas, $activations pendaftaran: tombol Pilih Kelas bisa dicapai di atas menu bawah',
        (tester) async {
      count = activations;
      await openPage(tester, '/home/payment-status');
      await expectButtonAboveNavbar(tester, 'Pilih Kelas');
    });
  }
}
