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
import 'package:silab/features/classes/data/data_sources/classes_api_service.dart';
import 'package:silab/features/classes/data/repository/class_repository_impl.dart';
import 'package:silab/features/classes/domain/usecases/get_user_registered_classes_usecase.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';
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
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_event.dart';
import 'package:silab/features/select_subjects/presentation/pages/payment_status_page.dart';
import 'package:silab/features/select_subjects/presentation/pages/pilih_kelas_page.dart';
import 'package:silab/features/select_subjects/presentation/widgets/pick_class_banner.dart';
import 'package:silab/features/user_details/data/data_sources/user_api_service.dart';
import 'package:silab/features/user_details/data/repositories/user_repository_impl.dart';
import 'package:silab/features/user_details/domain/usecases/get_assisted_classes_usecase.dart';
import 'package:silab/features/user_details/domain/usecases/get_user_details_usecase.dart';
import 'package:silab/features/user_details/presentation/bloc/assisted_classes/assisted_classes_bloc.dart';
import 'package:silab/features/user_details/presentation/bloc/user_details_bloc.dart';
import 'package:silab/features/user_details/presentation/pages/profile_page.dart';

const menuLabel = 'Pembayaran & Kelas';
const chosenBD = 'Kelas: A · Senin, 08:00 - 10:00';
const notChosen = 'Kelas: belum dipilih';
const waitPaid = 'Kelas: bisa dipilih setelah lunas';
const noClassYet = 'Kelas: belum tersedia';
const chosenJK = 'Kelas: B · Rabu, 13:00 - 15:00';

Map<String, dynamic> kelas(String id, String name, String day, String time) => {
      'id': id,
      'name': name,
      'day': day,
      'session_time': time,
      'room': 'Lab RPL',
      'quota': 30,
      'registered_students': 5,
      'is_full': false,
    };

Map<String, dynamic> activation(
  String id,
  String subject,
  bool paid, {
  Map<String, dynamic>? registered,
  List<Map<String, dynamic>> classes = const [],
}) =>
    {
      'id': id,
      'status': paid,
      'created_at': '2026-09-30T02:00:00.000Z',
      'subject_id': 's-$id',
      'subjects': [
        {'subject_name': subject, 'semester': '3'},
      ],
      'registered_class': registered,
      'available_classes': classes,
    };

http.Response jsonResponse(Object body, int status) =>
    http.Response(jsonEncode(body), status);

void main() {
  late SharedPreferences prefs;
  late List<http.Request> requests;
  late List<Map<String, dynamic>> activations;

  final jkA = kelas('k-jk-a', 'A', 'TUESDAY', '10:00 - 12:00');
  final jkB = kelas('k-jk-b', 'B', 'WEDNESDAY', '13:00 - 15:00');

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({
      'accessToken': 'akses',
      'refreshToken': 'segar',
    });
    prefs = await SharedPreferences.getInstance();
    requests = [];
    activations = [
      activation('a-bd', 'Basis Data', true,
          registered: {'id': 'k-bd-a', 'name': 'A'},
          classes: [kelas('k-bd-a', 'A', 'MONDAY', '08:00 - 10:00')]),
      activation('a-jk', 'Jaringan Komputer', true, classes: [jkA, jkB]),
      activation('a-alg', 'Algoritma', false,
          classes: [kelas('k-alg-a', 'A', 'THURSDAY', '07:00 - 09:00')]),
      activation('a-so', 'Sistem Operasi', true),
    ];
  });

  List<Map<String, dynamic>> classOptions() => [
        for (final a in activations)
          if (a['status'] == true && a['registered_class'] == null)
            for (final c in a['available_classes'] as List)
              {
                'id': c['id'],
                'subject_name': (a['subjects'] as List).first['subject_name'],
                'subject_class': c['name'],
                'semester': '3',
                'session_time': c['session_time'],
                'quota': c['quota'],
                'registered_students': c['registered_students'],
                'day': c['day'],
              },
      ];

  Future<http.Response> backend(http.Request request) async {
    requests.add(request);
    final path = request.url.path;
    final ok = {'status': true, 'message': 'Berhasil'};

    if (request.method == 'GET' && path == '/activation') {
      return jsonResponse({...ok, 'data': activations}, 200);
    }

    if (request.method == 'GET' && path == '/class/registration') {
      return jsonResponse({...ok, 'data': classOptions()}, 200);
    }

    if (request.method == 'POST' && path == '/class/registration') {
      final ids = (jsonDecode(request.body)['classIds'] as List).cast<String>();
      for (final a in activations) {
        for (final c in a['available_classes'] as List) {
          if (ids.contains(c['id'])) {
            a['registered_class'] = {'id': c['id'], 'name': c['name']};
          }
        }
      }
      return jsonResponse(ok, 200);
    }

    if (request.method == 'GET' && path == '/class/me') {
      return jsonResponse({...ok, 'data': []}, 200);
    }

    if (request.method == 'GET' && path == '/class') {
      return jsonResponse({...ok, 'data': []}, 200);
    }

    if (request.method == 'GET' && path == '/auth/me') {
      return jsonResponse({
        ...ok,
        'data': {
          'nim': '2211102001',
          'name': 'Budi Santoso',
          'email': 'budi@silab.test',
        },
      }, 200);
    }

    return jsonResponse({'status': false, 'message': 'Not Found'}, 404);
  }

  Future<GoRouter> openApp(WidgetTester tester, String initialLocation) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final api = ApiClient(MockClient(backend), prefs);
    final subjects =
        SelectedSubjectRepositoryImpl(SelectedSubjectApiService(api));
    final classes = ClassRepositoryImpl(ClassesApiService(api));
    final users = UserRepositoryImpl(UserApiService(api));

    final router = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      initialLocation: initialLocation,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => Scaffold(
            appBar: AppBar(
              title: Builder(
                builder: (context) =>
                    Text('judul:${GoRouterState.of(context).uri}'),
              ),
            ),
            body: navigationShell,
          ),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const Material(
                  child: Column(children: [Text('Beranda'), PickClassBanner()]),
                ),
                routes: [
                  GoRoute(
                    path: 'payment-status',
                    name: 'payment-status',
                    builder: (context, state) => BlocProvider(
                      create: (_) => CancelActivationBloc(
                          CancelActivationUsecase(subjects)),
                      child: const PaymentStatusPage(),
                    ),
                  ),
                  GoRoute(
                    path: 'pilih-kelas',
                    name: 'pilih-kelas',
                    builder: (context, state) => const PilihKelasPage(),
                  ),
                ],
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ]),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SelectedSubjectByNimBloc(
              GetSelectedSubjectByNimUsecase(subjects)),
        ),
        BlocProvider(
          create: (_) => UserClassOptionByPaidSubjectBloc(
              GetUserClassOptionByPaidSubjectUsecase(subjects))
            ..add(GetUserClassOptionByPaidSubject()),
        ),
        BlocProvider(
          create: (_) =>
              AddSelectedClassBloc(AddSelectedClassUseCase(subjects)),
        ),
        BlocProvider(
          create: (_) =>
              UserRegisteredClassBloc(GetUserRegisteredClassesUseCase(classes)),
        ),
        BlocProvider(
          create: (_) => UserDetailsBloc(GetUserDetailsUseCase(users)),
        ),
        BlocProvider(
          create: (_) => AssistedClassesBloc(GetAssistedClassesUsecase(users)),
        ),
      ],
      child: MaterialApp.router(routerConfig: router),
    ));
    await tester.pumpAndSettle();
    return router;
  }

  String showing() {
    if (find.byType(PilihKelasPage).evaluate().isNotEmpty) return 'pilih-kelas';
    if (find.byType(PaymentStatusPage).evaluate().isNotEmpty) {
      return 'payment-status';
    }
    if (find.byType(ProfilePage).evaluate().isNotEmpty) return 'profile';
    if (find.text('Beranda').evaluate().isNotEmpty) return 'home';
    return '?';
  }

  Finder title(String uri) => find.text('judul:$uri');

  Future<void> tapText(WidgetTester tester, String text) async {
    await tester.ensureVisible(find.text(text).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(text).first);
    await tester.pumpAndSettle();
  }

  Future<void> saveClassB(WidgetTester tester) async {
    expect(
        find.text(
            'Pilih kelas yang anda inginkan. Sesuaikan dengan jadwal anda!'),
        findsOneWidget);
    await tapText(tester, 'Rabu, 13:00 - 15:00');
    await tapText(tester, 'Simpan');
    expect(find.text('Simpan Pilihan Kelas'), findsOneWidget);
    await tester.tap(find.text('Simpan').last);
    await tester.pumpAndSettle();
    expect(
        find.text('Anda sudah terdaftar di kelas praktikum'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    final posts = requests.where((r) => r.method == 'POST').toList();
    expect(posts, hasLength(1));
    expect(jsonDecode(posts.single.body), {
      'classIds': ['k-jk-b'],
    });
  }

  testWidgets('tiap kartu punya baris Kelas sesuai keadaannya', (tester) async {
    await openApp(tester, '/home/payment-status');

    expect(find.text(chosenBD), findsOneWidget);
    expect(find.text(notChosen), findsOneWidget);
    expect(find.text(waitPaid), findsOneWidget);
    expect(find.text(noClassYet), findsOneWidget);

    final order = [
      'Basis Data',
      chosenBD,
      'Jaringan Komputer',
      notChosen,
      'Algoritma',
      waitPaid,
      'Sistem Operasi',
      noClassYet,
    ];
    for (var i = 1; i < order.length; i++) {
      expect(
        tester.getRect(find.text(order[i])).top,
        greaterThanOrEqualTo(tester.getRect(find.text(order[i - 1])).bottom),
        reason: '${order[i]} harus di bawah ${order[i - 1]}',
      );
    }

    final chosenStyle = tester.widget<Text>(find.text(chosenBD)).style!;
    expect(chosenStyle.color, const Color(0xff3272CA));
  });

  testWidgets('kelas yang dipindah laboran tetap tampil walau belum lunas',
      (tester) async {
    activations[2]['registered_class'] = {'id': 'k-alg-a', 'name': 'A'};
    await openApp(tester, '/home/payment-status');

    expect(find.text('Kelas: A · Kamis, 07:00 - 09:00'), findsOneWidget);
    expect(find.text(waitPaid), findsNothing);
  });

  testWidgets('menu Profil: Pembayaran & Kelas menggantikan Riwayat Pembayaran',
      (tester) async {
    await openApp(tester, '/profile');

    expect(find.text('Riwayat Pembayaran'), findsNothing);
    expect(find.text(menuLabel), findsOneWidget);

    await tapText(tester, menuLabel);

    expect(showing(), 'payment-status');
    expect(title('/home/payment-status'), findsOneWidget);
    expect(find.text(notChosen), findsOneWidget);
  });

  testWidgets('dari Profil: setelah simpan kelas kembali ke Pembayaran & Kelas',
      (tester) async {
    await openApp(tester, '/profile');
    await tapText(tester, menuLabel);
    await tapText(tester, 'Pilih Kelas');
    expect(showing(), 'pilih-kelas');
    expect(title('/home/pilih-kelas'), findsOneWidget);

    await saveClassB(tester);

    expect(showing(), 'payment-status');
    expect(title('/home/payment-status'), findsOneWidget);
    expect(find.text(chosenJK), findsOneWidget);
    expect(find.text(notChosen), findsNothing);
  });

  testWidgets('dari banner Beranda: setelah simpan kelas kembali ke Beranda',
      (tester) async {
    await openApp(tester, '/home');
    expect(find.text('Anda dapat memilih kelas untuk 1 Mata Kuliah'),
        findsOneWidget);

    await tapText(tester, 'Anda dapat memilih kelas untuk 1 Mata Kuliah');
    expect(showing(), 'pilih-kelas');
    expect(title('/home/pilih-kelas'), findsOneWidget);

    await saveClassB(tester);

    expect(showing(), 'home');
    expect(title('/home'), findsOneWidget);
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Anda dapat memilih kelas untuk 1 Mata Kuliah'),
        findsNothing);
  });
}
