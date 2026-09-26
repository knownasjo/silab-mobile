import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_daftar_praktikum_subject_item.dart';
import 'package:silab/features/subjects/domain/entities/subject/subject_entity.dart';
import 'package:silab/features/subjects/presentation/bloc/subject_list/subject_list_bloc.dart';

Widget itemFor(SubjectEntity subject) => MaterialApp(
      home: Scaffold(
        body: BuildDaftarPraktikumSubjectItem(
          state: SubjectListSuccess(subjectList: [subject]),
          index: 0,
          userSelectedSubjectsId: const [],
          onChanged: (_) {},
        ),
      ),
    );

void main() {
  testWidgets('kode mata kuliah tampil di bawah nama', (tester) async {
    await tester.pumpWidget(itemFor(const SubjectEntity(
      id: 's1',
      subject_code: '553310001',
      subject_name: 'Algoritma dan Pemrograman',
      semester: '1',
    )));

    expect(find.text('Algoritma dan Pemrograman'), findsOneWidget);
    expect(find.text('553310001'), findsOneWidget);

    final tile = tester.widget<CheckboxListTile>(find.byType(CheckboxListTile));
    expect((tile.subtitle! as Text).data, '553310001');
  });

  testWidgets('tanpa kode, hanya nama yang tampil', (tester) async {
    await tester.pumpWidget(itemFor(const SubjectEntity(
      id: 's2',
      subject_name: 'Data Mining',
      semester: '5',
    )));

    expect(find.text('Data Mining'), findsOneWidget);
    final tile = tester.widget<CheckboxListTile>(find.byType(CheckboxListTile));
    expect(tile.subtitle, isNull);
  });
}
