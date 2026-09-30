import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/select_subjects/data/data_sources/selected_subject_api_service.dart';
import 'package:silab/features/select_subjects/data/repository/selected_subject_repository_impl.dart';
import 'package:silab/features/select_subjects/domain/usecases/cancel_activation_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_class_option_by_paid_subject_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_selected_subject_usecase.dart';
import 'package:silab/features/select_subjects/presentation/bloc/cancel_activation/cancel_activation_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/selected_subject_by_nim/selected_subject_by_nim_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/pages/payment_status_page.dart';

const cancelLabel = 'Batalkan pendaftaran';

Map<String, dynamic> activation(String id, String subject, bool status) => {
      'id': id,
      'status': status,
      'created_at': '2026-09-30T02:00:00.000Z',
      'subjects': [
        {'subject_name': subject, 'semester': '3'},
      ],
    };

http.Response jsonResponse(Object body, int status) =>
    http.Response(jsonEncode(body), status);

void main() {
  late SharedPreferences prefs;
  late List<http.Request> requests;
  late List<Map<String, dynamic>> activations;
  late Map<String, http.Response> deleteReplies;
  Completer<void>? holdDelete;

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({
      'accessToken': 'akses',
      'refreshToken': 'segar',
    });
    prefs = await SharedPreferences.getInstance();
    requests = [];
    activations = [
      activation('a-lunas', 'Algoritma', true),
      activation('a-belum', 'Basis Data', false),
    ];
    deleteReplies = {};
    holdDelete = null;
  });

  Future<http.Response> backend(http.Request request) async {
    requests.add(request);
    final path = request.url.path;

    if (request.method == 'GET' && path == '/activation') {
      return jsonResponse(
          {'status': true, 'message': 'Berhasil', 'data': activations}, 200);
    }

    if (request.method == 'GET' && path == '/class/registration') {
      return jsonResponse(
          {'status': true, 'message': 'Berhasil', 'data': []}, 200);
    }

    if (request.method == 'DELETE' && path.startsWith('/activation/')) {
      await holdDelete?.future;
      final id = path.split('/').last;
      final reply = deleteReplies[id];
      if (reply != null) return reply;

      final removed = activations.firstWhere((a) => a['id'] == id);
      activations.remove(removed);
      final subject = (removed['subjects'] as List).first['subject_name'];
      return jsonResponse(
          {'status': true, 'message': 'Pendaftaran $subject dibatalkan.'}, 200);
    }

    return jsonResponse({'status': false, 'message': 'Not Found'}, 404);
  }

  Future<void> openPage(WidgetTester tester) async {
    final repository = SelectedSubjectRepositoryImpl(
      SelectedSubjectApiService(ApiClient(MockClient(backend), prefs)),
    );

    await tester.pumpWidget(MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SelectedSubjectByNimBloc(
                GetSelectedSubjectByNimUsecase(repository)),
          ),
          BlocProvider(
            create: (_) => UserClassOptionByPaidSubjectBloc(
                GetUserClassOptionByPaidSubjectUsecase(repository)),
          ),
          BlocProvider(
            create: (_) =>
                CancelActivationBloc(CancelActivationUsecase(repository)),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(title: const Text('Status Pembayaran')),
          body: const PaymentStatusPage(),
        ),
      ),
    ));
    await tester.pumpAndSettle();
  }

  List<http.Request> deletes() =>
      requests.where((r) => r.method == 'DELETE').toList();

  Future<void> tapCancel(WidgetTester tester) async {
    await tester.tap(find.text(cancelLabel));
    await tester.pumpAndSettle();
  }

  testWidgets('tombol batal hanya ada di pendaftaran yang belum lunas',
      (tester) async {
    await openPage(tester);

    expect(find.text('Lunas'), findsOneWidget);
    expect(find.text('Belum Lunas'), findsOneWidget);
    expect(find.text(cancelLabel), findsOneWidget);

    final button = tester.getRect(find.text(cancelLabel));
    final unpaid = tester.getRect(find.text('Basis Data'));
    final paid = tester.getRect(find.text('Algoritma'));
    expect(button.top, greaterThan(unpaid.bottom));
    expect(paid.bottom, lessThan(unpaid.top));
  });

  testWidgets('Kembali menutup konfirmasi tanpa membatalkan', (tester) async {
    await openPage(tester);
    await tapCancel(tester);

    expect(find.text('Batalkan Pendaftaran'), findsOneWidget);
    expect(
      find.text(
          'Pendaftaran Basis Data akan dibatalkan. Anda bisa mendaftarkannya lagi nanti.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Kembali'));
    await tester.pumpAndSettle();

    expect(find.text('Batalkan Pendaftaran'), findsNothing);
    expect(deletes(), isEmpty);
    expect(find.text('Basis Data'), findsOneWidget);
  });

  testWidgets('Ya, batalkan menghapus pendaftaran dan daftar diperbarui',
      (tester) async {
    await openPage(tester);
    holdDelete = Completer<void>();
    await tapCancel(tester);
    await tester.tap(find.text('Ya, batalkan'));
    await tester.pump();

    expect(find.text('Membatalkan...'), findsOneWidget);
    final button = tester.widget<TextButton>(find.ancestor(
      of: find.text('Membatalkan...'),
      matching: find.byType(TextButton),
    ));
    expect(button.onPressed, isNull);

    holdDelete!.complete();
    await tester.pumpAndSettle();

    expect(deletes().single.url.path, '/activation/a-belum');
    expect(deletes().single.headers['Authorization'], 'Bearer akses');
    expect(find.text('Pendaftaran Basis Data dibatalkan.'), findsOneWidget);
    expect(find.text('Basis Data'), findsNothing);
    expect(find.text(cancelLabel), findsNothing);
    expect(find.text('Algoritma'), findsOneWidget);
  });

  testWidgets('penolakan server tampil dan tombol bisa ditekan lagi',
      (tester) async {
    const message =
        'Pendaftaran yang sudah lunas tidak bisa dibatalkan. Hubungi laboran bila perlu dibatalkan.';
    deleteReplies['a-belum'] =
        jsonResponse({'status': false, 'message': message}, 409);

    await openPage(tester);
    await tapCancel(tester);
    await tester.tap(find.text('Ya, batalkan'));
    await tester.pumpAndSettle();

    expect(find.text(message), findsOneWidget);
    expect(find.text('Basis Data'), findsOneWidget);
    final button = tester.widget<TextButton>(find.ancestor(
      of: find.text(cancelLabel),
      matching: find.byType(TextButton),
    ));
    expect(button.onPressed, isNotNull);
  });
}
