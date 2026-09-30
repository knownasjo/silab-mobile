import 'package:flutter/material.dart';
import 'package:silab/features/subjects/domain/entities/subject/subject_entity.dart';
import 'package:silab/features/subjects/presentation/bloc/subject_list/subject_list_bloc.dart';

class BuildDaftarPraktikumSubjectItem extends StatelessWidget {
  final SubjectListState state;
  final int index;
  final List<SubjectEntity> userSelectedSubjectsId;
  final Function(bool?)? onChanged;
  final bool isRegistered;

  const BuildDaftarPraktikumSubjectItem({
    super.key,
    required this.onChanged,
    required this.state,
    required this.index,
    required this.userSelectedSubjectsId,
    this.isRegistered = false,
  });

  @override
  Widget build(BuildContext context) {
    final code = state.subjectList?[index].subject_code;
    final subtitle = [
      if (code != null) code,
      if (isRegistered) 'Sudah didaftarkan',
    ].join(' · ');

    return CheckboxListTile.adaptive(
      activeColor: const Color(0xff3272CA),
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: const BorderSide(
        color: Color(0xff1d1d1d),
        width: 1,
      ),
      value: isRegistered ||
          userSelectedSubjectsId.contains(
              state.subjectList != null ? state.subjectList![index] : ''),
      onChanged: isRegistered ? null : onChanged,
      dense: true,
      title: Text(
        state.subjectList != null
            ? state.subjectList![index].subject_name!
            : 'Subject Name',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Color(0x991D1D1D)),
            )
          : null,
    );
  }
}
