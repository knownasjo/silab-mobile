import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/exceptions/exceptions.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/announcement/data/data_sources/announcement_api_service.dart';
import 'package:silab/features/authentication/data/data_sources/remote/authentication_api_service.dart';
import 'package:silab/features/authentication/data/models/login_model.dart';
import 'package:silab/features/classes/data/data_sources/classes_api_service.dart';
import 'package:silab/features/realtime/data/data_sources/realtime_api_service.dart';
import 'package:silab/features/schedule/data/data_sources/schedule_api_service.dart';
import 'package:silab/features/select_subjects/data/data_sources/selected_subject_api_service.dart';
import 'package:silab/features/subjects/data/data_sources/subject_api_service.dart';
import 'package:silab/features/user_details/data/data_sources/user_api_service.dart';

const baseUrl = String.fromEnvironment('API_BASE_URL');
const nim = String.fromEnvironment('TEST_NIM', defaultValue: '2000016099');
const password =
    String.fromEnvironment('TEST_PASSWORD', defaultValue: 'mahasiswa001');

void main() {
  late ApiClient api;
  late String accessToken;
  late String refreshToken;

  group('alur mahasiswa terhadap backend asli', () {
    setUpAll(() async {
      AppConfig.create(baseUrl: baseUrl);
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      api = ApiClient(http.Client(), prefs);

      final login = await AuthenticationApiService(api)
          .userLogin(const LoginModel(nim: nim, password: password));
      accessToken = login.data!.accessToken!;
      refreshToken = login.data!.refreshToken!;
      await prefs.setString('accessToken', accessToken);
    });

    test('akun uji berperan MAHASISWA dan profilnya terbaca', () async {
      expect(
        await AuthenticationApiService(api).getUserRole(accessToken),
        'MAHASISWA',
      );

      final profile = await UserApiService(api).getUserDetails();

      expect(profile.data?.nim, nim);
      expect(profile.data?.fullname, isNotEmpty);
    });

    test('refresh token dari login ditukar dengan access token baru', () async {
      final json =
          await api.post('/auth/refresh', body: {'refreshToken': refreshToken});
      final newAccessToken = (json['data'] as Map)['accessToken'] as String;

      expect(
        await AuthenticationApiService(api).getUserRole(newAccessToken),
        'MAHASISWA',
      );
    });

    test('kelas, pertemuan, dan jadwal', () async {
      final classes =
          (await ClassesApiService(api).getUserRegisteredClasses()).data!;

      for (final c in classes) {
        expect(c.subject_name, isNotEmpty);

        final classmates =
            (await ClassesApiService(api).getClassmates(classId: c.id)).data!;
        expect(classmates.where((m) => m.is_me == true), hasLength(1),
            reason: 'mahasiswa uji harus muncul sekali di ${c.subject_name}');

        final meetings =
            (await ClassesApiService(api).getUserMeetingsData(classId: c.id))
                .data!;
        for (final m in meetings) {
          expect(m.is_open, isNotNull,
              reason: '${m.meeting_name} tanpa is_open');
          m.attendanceStatus;
        }
      }

      final schedule = await ScheduleApiService(api).getUserSchedule();
      expect(
        schedule.expand((day) => day.practicums!).length,
        classes.length,
      );
    });

    test('stream real-time tersambung dan mengirim "ready"', () async {
      final firstEvent = await RealtimeApiService(api)
          .watchEvents()
          .first
          .timeout(const Duration(seconds: 10));

      expect(firstEvent.type, 'ready');
    });

    test('pendaftaran praktikum dan pilihan kelas', () async {
      final subjects = (await SubjectApiService(api).getSubjectList()).data!;
      expect(subjects, isNotEmpty);

      final activations =
          await SelectedSubjectApiService(api).getUserSelectedSubject();
      for (final a in activations.data!) {
        expect(a.status, isNotNull);
        expect(DateTime.tryParse(a.created_at!), isNotNull);
      }

      final options = await SelectedSubjectApiService(api)
          .getUserClassOptionbyPaidSubjects();
      for (final o in options.data!) {
        expect(o.quota, isNotNull);
        expect(o.registered_students, isNotNull);
      }
    });

    test('pengumuman', () async {
      final announcements =
          (await AnnouncementApiService(api).getAnnouncementList()).data!;

      if (announcements.isNotEmpty) {
        final detail = await AnnouncementApiService(api)
            .getAnnouncement(id: announcements.first.id);
        expect(detail.data?.title, announcements.first.title);
      }
    });

    test('presensi ke sesi tertutup ditolak dengan pesan backend', () async {
      final classes =
          (await ClassesApiService(api).getUserRegisteredClasses()).data!;
      final closedMeeting = classes.isEmpty
          ? null
          : (await ClassesApiService(api)
                  .getUserMeetingsData(classId: classes.first.id))
              .data!
              .where((m) => m.is_open == false)
              .firstOrNull;

      if (closedMeeting == null) {
        markTestSkipped('Tidak ada pertemuan tertutup untuk dicoba');
        return;
      }

      await expectLater(
        ClassesApiService(api).addUserAttendance(
          classId: classes.first.id,
          meetingId: closedMeeting.id,
          meetingToken: 'abcdef',
        ),
        throwsA(isA<RequestErrorException>().having(
            (e) => e.message, 'message', 'Sesi presensi belum dibuka!')),
      );
    });
  },
      skip: baseUrl.isEmpty
          ? 'Butuh --dart-define=API_BASE_URL=<alamat silab-backend>'
          : false);
}
