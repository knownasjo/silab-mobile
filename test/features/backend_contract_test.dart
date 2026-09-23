// Memastikan setiap entity bisa membaca respons silab-backend apa adanya.
// Contoh JSON di bawah diambil dari respons backend yang sebenarnya.

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/announcement/domain/entities/announcement_list_response/announcement_list_response_entity.dart';
import 'package:silab/features/authentication/domain/entities/login_response/login_response_entity.dart';
import 'package:silab/features/classes/domain/entities/attendance/attendance_entity.dart';
import 'package:silab/features/classes/domain/entities/class_list_response/classes_response_entity.dart';
import 'package:silab/features/classes/domain/entities/classmates_response/classmates_response_entity.dart';
import 'package:silab/features/classes/domain/entities/meetings/meetings_entity.dart';
import 'package:silab/features/classes/domain/entities/meetings_response/meetings_response_entity.dart';
import 'package:silab/features/schedule/data/data_sources/schedule_api_service.dart';
import 'package:silab/features/select_subjects/domain/entities/selected_subject_response/selected_subject_response_entity.dart';
import 'package:silab/features/select_subjects/domain/entities/user_class_option_by_paid_subject_response/user_class_option_by_paid_subject_response_entity.dart';
import 'package:silab/features/subjects/domain/entities/subject_list_response/subject_list_response_entity.dart';
import 'package:silab/features/user_details/domain/entities/user_detail_response/user_detail_response_entity.dart';

Map<String, dynamic> json(String source) =>
    jsonDecode(source) as Map<String, dynamic>;

const myClassesJson = '''
{"status":true,"message":"Berhasil","data":[
  {"id":"c-rpl","subject_id":"s2","subject_name":"Rekayasa Perangkat Lunak","subject_class":"B","semester":"4","lecturer":"Dosen001","day":"WEDNESDAY","session_time":"10.00 - 11.30","room":"SBTI"},
  {"id":"c-alpro","subject_id":"s1","subject_name":"Algoritma dan Pemrograman","subject_class":"A","semester":"1","lecturer":"Jordan","day":"MONDAY","session_time":"07.00 - 08.30","room":"PSI"},
  {"id":"c-imk","subject_id":"s3","subject_name":"Interaksi Manusia dan Komputer","subject_class":"A","semester":"4","lecturer":"Dosen001","day":"MONDAY","session_time":"13.00 - 14.30","room":"PSI"}
]}''';

void main() {
  test('login: token dibaca dari status boolean', () {
    final login = LoginResponseEntity.fromJson(json(
        '{"status":true,"message":"Login Successful","data":{"accessToken":"a","refreshToken":"r"}}'));

    expect(login.status, true);
    expect(login.data?.accessToken, 'a');
  });

  test('profil: "name" dari /auth/me dibaca sebagai fullname', () {
    final me = UserDetailResponseEntity.fromJson(json(
        '{"status":true,"message":"Success get user data!","data":{"id":"u1","nim":"2000016099","name":"Mahasiswa001","email":"m@webmail.uad.ac.id","role":"MAHASISWA"}}'));

    expect(me.data?.fullname, 'Mahasiswa001');
    expect(me.data?.nim, '2000016099');
  });

  test('kelas saya dari /class/me', () {
    final classes = ClassesResponseEntity.fromJson(json(myClassesJson));

    expect(classes.data, hasLength(3));
    expect(classes.data!.first.subject_class, 'B');
    expect(classes.data!.first.session_time, '10.00 - 11.30');
  });

  test('pertemuan: tiga status presensi sama dengan aturan di web', () {
    final meetings = MeetingsResponseEntity.fromJson(json('''
{"status":true,"message":"Berhasil","data":[
  {"id":"m1","meeting_name":"Pertemuan 1","is_open":false,"submitted_at":"2026-09-20T14:49:45.619Z","is_attended":true},
  {"id":"m2","meeting_name":"Pertemuan 2","is_open":false,"submitted_at":"2026-09-21T07:00:00.000Z","is_attended":false},
  {"id":"m3","meeting_name":"Pertemuan 3","is_open":true,"submitted_at":null,"is_attended":false}
]}''')).data!;

    expect(meetings.map((m) => m.attendanceStatus), [
      AttendanceStatus.hadir,
      AttendanceStatus.tidakHadir,
      AttendanceStatus.belumPresensi,
    ]);
    expect(meetings.last.is_open, true);
  });

  test('teman sekelas dari /class/:id/classmates: hanya nama dan is_me', () {
    final classmates = ClassmatesResponseEntity.fromJson(json('''
{"status":true,"message":"Berhasil","data":[
  {"name":"Jordan","is_me":false},
  {"name":"Mahasiswa001","is_me":true},
  {"name":"Mahasiswa002","is_me":false}
]}''')).data!;

    expect(classmates.map((c) => c.name),
        ['Jordan', 'Mahasiswa001', 'Mahasiswa002']);
    expect(
        classmates.where((c) => c.is_me == true).single.name, 'Mahasiswa001');
  });

  test('presensi berhasil', () {
    final attendance = AttendanceEntity.fromJson(json(
        '{"status":true,"message":"Presensi berhasil dicatat","data":{"meeting_id":"m3","meeting_name":"Pertemuan 3","student_name":"Mahasiswa001","nim":"2000016099","submitted_at":"2026-09-23T03:13:42.747Z"}}'));

    expect(attendance.status, true);
    expect(attendance.message, 'Presensi berhasil dicatat');
  });

  test('status pembayaran dari /activation', () {
    final activations = SelectedSubjectResponseEntity.fromJson(json('''
{"status":true,"message":"Berhasil","data":[{"id":"f7e2d725","user_id":"u1","nim":"2000016099","student":"Mahasiswa001","status":true,"created_at":"2025-05-01T03:50:04.571Z","subject_id":"s1",
 "subjects":[{"subject_name":"Algoritma dan Pemrograman","semester":"1"}],
 "registered_class":{"id":"c-alpro","name":"A"},"available_classes":[]}]}'''))
        .data!;

    expect(activations.single.activation_id, 'f7e2d725');
    expect(activations.single.status, true);
    expect(activations.single.created_at, '2025-05-01T03:50:04.571Z');
    expect(activations.single.subjects!.single.subject_name,
        'Algoritma dan Pemrograman');
  });

  test('pilihan kelas dari /class/registration: kuota berupa angka', () {
    final options = UserClassOptionByPaidSubjectResponseEntity.fromJson(json('''
{"status":true,"message":"Success","data":[{"id":"c-b","subject_name":"Algoritma dan Pemrograman","subject_class":"B","semester":"1","quota":25,"day":"TUESDAY","registered_students":24,"session_time":"09.00 - 10.30"}]}'''))
        .data!;

    expect(options.single.class_id, 'c-b');
    expect(options.single.quota, 25);
    expect(options.single.registered_students, 24);
  });

  test('daftar mata kuliah dari /subject', () {
    final subjects = SubjectListResponseEntity.fromJson(json('''
{"status":true,"message":"Success","data":[{"id":"23b860ef","subject_code":"002","subject_name":"Rekayasa Perangkat Lunak","semester":"4","lecturer":"Dosen001"}]}'''))
        .data!;

    expect(subjects.single.subject_name, 'Rekayasa Perangkat Lunak');
    expect(subjects.single.semester, '4');
  });

  test('pengumuman dari /announcement', () {
    final announcements = AnnouncementListResponseEntity.fromJson(json('''
{"status":true,"message":"Success","data":[{"id":"a1","title":"Jadwal Inhall","body":"Isi","author":"Laboran002","created_at":"2026-09-01T00:00:00.000Z","type":"INHALL"}]}'''))
        .data!;

    expect(announcements.single.author, 'Laboran002');
    expect(announcements.single.type, 'INHALL');
  });

  test('jadwal disusun dari /class/me: urut hari, nama hari bahasa Indonesia',
      () async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({'accessToken': 't'});
    final api = ApiClient(
      MockClient((_) async => http.Response(myClassesJson, 200)),
      await SharedPreferences.getInstance(),
    );

    final schedule = await ScheduleApiService(api).getUserSchedule();

    expect(schedule.map((s) => s.day), ['Senin', 'Rabu']);
    expect(schedule.first.practicums!.map((p) => p.session),
        ['07.00 - 08.30', '13.00 - 14.30']);
  });
}
