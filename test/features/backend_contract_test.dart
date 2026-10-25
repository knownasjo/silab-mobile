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
  {"id":"c-rpl","subjectId":"s2","subjectName":"Rekayasa Perangkat Lunak","subjectClass":"B","semester":"4","lecturer":"Dosen001","day":"WEDNESDAY","sessionTime":"10.00 - 11.30","room":"SBTI"},
  {"id":"c-alpro","subjectId":"s1","subjectName":"Algoritma dan Pemrograman","subjectClass":"A","semester":"1","lecturer":"Jordan","day":"MONDAY","sessionTime":"07.00 - 08.30","room":"PSI"},
  {"id":"c-imk","subjectId":"s3","subjectName":"Interaksi Manusia dan Komputer","subjectClass":"A","semester":"4","lecturer":"Dosen001","day":"MONDAY","sessionTime":"13.00 - 14.30","room":"PSI"}
]}''';

const assistedClassesJson = '''
{"status":true,"message":"Berhasil","data":[
  {"id":"c-jk","subjectId":"s4","name":"B","subjectName":"Jaringan Komputer","semester":"3","quota":30,"isFull":false,"room":"SBTI","sessionId":"sesi-2","day":"MONDAY","startAt":"10.00","endAt":"11.30","participants":12}
]}''';

void main() {
  test('login: token dibaca dari status boolean', () {
    final login = LoginResponseEntity.fromJson(json(
        '{"status":true,"message":"Login berhasil","data":{"accessToken":"a","refreshToken":"r"}}'));

    expect(login.status, true);
    expect(login.data?.accessToken, 'a');
  });

  test('profil: "name" dari /auth/me dibaca sebagai fullname', () {
    final me = UserDetailResponseEntity.fromJson(json(
        '{"status":true,"message":"Berhasil","data":{"id":"u1","nim":"2000016099","name":"Mahasiswa001","email":"m@webmail.uad.ac.id","role":"MAHASISWA"}}'));

    expect(me.data?.fullname, 'Mahasiswa001');
    expect(me.data?.nim, '2000016099');
  });

  test('kelas saya dari /class/me', () {
    final classes = ClassesResponseEntity.fromJson(json(myClassesJson));

    expect(classes.data, hasLength(3));
    expect(classes.data!.first.subjectClass, 'B');
    expect(classes.data!.first.sessionTime, '10.00 - 11.30');
  });

  test('pertemuan: tiga status presensi sama dengan aturan di web', () {
    final meetings = MeetingsResponseEntity.fromJson(json('''
{"status":true,"message":"Berhasil","data":[
  {"id":"m1","meetingName":"Pertemuan 1","isOpen":false,"submittedAt":"2026-09-20T14:49:45.619Z","isAttended":true},
  {"id":"m2","meetingName":"Pertemuan 2","isOpen":false,"submittedAt":"2026-09-21T07:00:00.000Z","isAttended":false},
  {"id":"m3","meetingName":"Pertemuan 3","isOpen":true,"submittedAt":null,"isAttended":false}
]}''')).data!;

    expect(meetings.map((m) => m.attendanceStatus), [
      AttendanceStatus.hadir,
      AttendanceStatus.tidakHadir,
      AttendanceStatus.belumPresensi,
    ]);
    expect(meetings.last.isOpen, true);
  });

  test('teman sekelas dari /class/:id/classmates: hanya nama dan isMe', () {
    final classmates = ClassmatesResponseEntity.fromJson(json('''
{"status":true,"message":"Berhasil","data":[
  {"name":"Jordan","isMe":false},
  {"name":"Mahasiswa001","isMe":true},
  {"name":"Mahasiswa002","isMe":false}
]}''')).data!;

    expect(classmates.map((c) => c.name),
        ['Jordan', 'Mahasiswa001', 'Mahasiswa002']);
    expect(
        classmates.where((c) => c.isMe == true).single.name, 'Mahasiswa001');
  });

  test('presensi berhasil', () {
    final attendance = AttendanceEntity.fromJson(json(
        '{"status":true,"message":"Presensi berhasil dicatat","data":{"meetingId":"m3","meetingName":"Pertemuan 3","studentName":"Mahasiswa001","nim":"2000016099","submittedAt":"2026-09-23T03:13:42.747Z"}}'));

    expect(attendance.status, true);
    expect(attendance.message, 'Presensi berhasil dicatat');
  });

  test('status pembayaran dari /activation', () {
    final activations = SelectedSubjectResponseEntity.fromJson(json('''
{"status":true,"message":"Berhasil","data":[{"id":"f7e2d725","userId":"u1","nim":"2000016099","student":"Mahasiswa001","status":true,"createdAt":"2025-05-01T03:50:04.571Z","subjectId":"s1",
 "subjects":[{"subjectName":"Algoritma dan Pemrograman","semester":"1"}],
 "registeredClass":{"id":"c-alpro","name":"A"},"availableClasses":[]}]}'''))
        .data!;

    expect(activations.single.activationId, 'f7e2d725');
    expect(activations.single.status, true);
    expect(activations.single.createdAt, '2025-05-01T03:50:04.571Z');
    expect(activations.single.subjects!.single.subjectName,
        'Algoritma dan Pemrograman');
  });

  test('pilihan kelas dari /class/registration: kuota berupa angka', () {
    final options = UserClassOptionByPaidSubjectResponseEntity.fromJson(json('''
{"status":true,"message":"Berhasil","data":[{"id":"c-b","subjectName":"Algoritma dan Pemrograman","subjectClass":"B","semester":"1","quota":25,"day":"TUESDAY","registeredStudents":24,"sessionTime":"09.00 - 10.30"}]}'''))
        .data!;

    expect(options.single.classId, 'c-b');
    expect(options.single.quota, 25);
    expect(options.single.registeredStudents, 24);
  });

  test('daftar mata kuliah dari /subject', () {
    final subjects = SubjectListResponseEntity.fromJson(json('''
{"status":true,"message":"Berhasil","data":[{"id":"23b860ef","subjectCode":"553310002","subjectName":"Rekayasa Perangkat Lunak","semester":"4","lecturer":"Dosen001"}]}'''))
        .data!;

    expect(subjects.single.subjectCode, '553310002');
    expect(subjects.single.subjectName, 'Rekayasa Perangkat Lunak');
    expect(subjects.single.semester, '4');
  });

  test('pengumuman dari /announcement', () {
    final announcements = AnnouncementListResponseEntity.fromJson(json('''
{"status":true,"message":"Berhasil","data":[{"id":"a1","title":"Jadwal Inhall","body":"Isi","author":"Laboran002","createdAt":"2026-09-01T00:00:00.000Z","type":"INHALL"}]}'''))
        .data!;

    expect(announcements.single.author, 'Laboran002');
    expect(announcements.single.type, 'INHALL');
  });

  test(
      'jadwal disusun dari /class/me dan kelas asisten /class: urut hari dan jam, nama hari bahasa Indonesia, ruang ikut',
      () async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({'accessToken': 't'});
    final api = ApiClient(
      MockClient((request) async => http.Response(
          request.url.path == '/class' ? assistedClassesJson : myClassesJson,
          200)),
      await SharedPreferences.getInstance(),
    );

    final schedule = await ScheduleApiService(api).getUserSchedule();

    expect(schedule.map((s) => s.day), ['Senin', 'Rabu']);
    final monday = schedule.first.practicums!;
    expect(monday.map((p) => p.session),
        ['07.00 - 08.30', '10.00 - 11.30', '13.00 - 14.30']);
    expect(monday.map((p) => p.room), ['PSI', 'SBTI', 'PSI']);
    expect(monday.map((p) => p.isAssistant == true), [false, true, false]);
    expect(monday[1].subjectName, 'Jaringan Komputer');
    expect(monday[1].subjectClass, 'B');
    expect(monday[1].classEntity, isNull);
    expect(monday.first.classEntity?.id, 'c-alpro');
    expect(monday.first.classEntity?.room, 'PSI');
  });
}
