import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/select_subjects/data/data_sources/selected_subject_api_service.dart';
import 'package:silab/features/select_subjects/data/repository/selected_subject_repository_impl.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_class_option_by_paid_subject_usecase.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_event.dart';
import 'package:silab/features/select_subjects/presentation/widgets/pick_class_banner.dart';

import '../../helpers/real_font.dart';

const bannerText = 'Anda dapat memilih kelas untuk 2 Mata Kuliah';

Map<String, dynamic> option(String id, String subject) => {
  'id': id,
  'subjectName': subject,
  'subjectClass': 'A',
  'semester': '3',
  'sessionTime': '07.00 - 08.40',
  'quota': 30,
  'registeredStudents': 5,
  'day': 'MONDAY',
};

void main() {
  late SharedPreferences prefs;

  setUpAll(loadRealFont);

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({
      'accessToken': 'akses',
      'refreshToken': 'segar',
    });
    prefs = await SharedPreferences.getInstance();
  });

  Future<http.Response> backend(http.Request request) async {
    if (request.url.path == '/class/registration') {
      return http.Response(
        jsonEncode({
          'status': true,
          'message': 'Berhasil',
          'data': [
            option('bd-a', 'Basis Data'),
            option('bd-b', 'Basis Data'),
            option('jk-a', 'Jaringan Komputer'),
          ],
        }),
        200,
      );
    }

    return http.Response('{"status":false,"message":"Not Found"}', 404);
  }

  Future<void> pumpBanner(WidgetTester tester, double width) async {
    tester.view.physicalSize = Size(width, 700) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final bloc = UserClassOptionByPaidSubjectBloc(
      GetUserClassOptionByPaidSubjectUsecase(
        SelectedSubjectRepositoryImpl(
          SelectedSubjectApiService(ApiClient(MockClient(backend), prefs)),
        ),
      ),
    )..add(GetUserClassOptionByPaidSubject());
    addTearDown(bloc.close);

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(
            body: Column(children: [SizedBox(height: 100), PickClassBanner()]),
          ),
        ),
        GoRoute(
          path: '/pilih-kelas',
          name: 'pilih-kelas',
          builder: (_, _) => const Text('Halaman Pilih Kelas'),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      BlocProvider.value(
        value: bloc,
        child: MaterialApp.router(
          theme: ThemeData(fontFamily: realFontFamily),
          routerConfig: router,
        ),
      ),
    );

    for (var i = 0; i < 5; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 20)),
      );
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pumpAndSettle();
  }

  Finder inBanner(Finder finder) =>
      find.descendant(of: find.byType(PickClassBanner), matching: finder);

  ({Rect box, Rect check, Rect text, Rect arrow}) parts(WidgetTester tester) =>
      (
        box: tester.getRect(inBanner(find.byType(DecoratedBox)).first),
        check: tester.getRect(inBanner(find.byType(Image))),
        text: tester.getRect(find.text(bannerText)),
        arrow: tester.getRect(find.byIcon(Boxicons.bx_chevron_right)),
      );

  void expectInsideWithGaps(WidgetTester tester) {
    final banner = parts(tester);

    expect(banner.arrow.right, lessThanOrEqualTo(banner.box.right - 8));
    expect(banner.check.left, greaterThanOrEqualTo(banner.box.left + 8));
    expect(banner.text.left - banner.check.right, greaterThanOrEqualTo(8));
    expect(banner.arrow.left - banner.text.right, greaterThanOrEqualTo(8));
    expect(
      tester
          .renderObject<RenderParagraph>(find.text(bannerText))
          .didExceedMaxLines,
      isFalse,
    );
  }

  for (final width in [320.0, 344.0]) {
    testWidgets(
      'layar $width: panah tetap di dalam kotak hijau dan tulisan berjarak 8 '
      'dari ikon serta panah',
      (tester) async {
        await pumpBanner(tester, width);

        expect(tester.takeException(), isNull);
        expect(find.text(bannerText), findsOneWidget);
        expectInsideWithGaps(tester);
      },
    );
  }

  for (final width in [360.0, 375.0, 411.0]) {
    testWidgets('layar $width: letak dan lebar banner sama dengan sebelumnya', (
      tester,
    ) async {
      await pumpBanner(tester, width);
      final banner = parts(tester);
      final gap = (width - 30 - 16 - 24 - 250 - 24) / 2;

      expect(tester.takeException(), isNull);
      expect(banner.box, Rect.fromLTWH(15, 100, width - 30, 72));
      expect(banner.check.left, 15 + 8);
      expect(banner.text.left, 15 + 8 + 24 + gap);
      expect(banner.text.width, 250);
      expect(banner.arrow.left, width - 15 - 8 - 24);
      expectInsideWithGaps(tester);
    });
  }

  testWidgets('banner di layar 320 tetap membuka Pilih Kelas', (tester) async {
    await pumpBanner(tester, 320);

    await tester.tap(find.text(bannerText));
    await tester.pumpAndSettle();

    expect(find.text('Halaman Pilih Kelas'), findsOneWidget);
  });
}
