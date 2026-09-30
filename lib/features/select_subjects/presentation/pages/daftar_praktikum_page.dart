import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_small_button.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/features/select_subjects/presentation/bloc/selected_subject_by_nim/selected_subject_by_nim_bloc.dart';
import 'package:silab/features/select_subjects/presentation/pages/ringkasan_daftar_page.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_daftar_praktikum_page_dropdown.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_daftar_praktikum_page_subject_empty.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_daftar_praktikum_page_subject_failed.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_daftar_praktikum_subject_item.dart';
import 'package:silab/features/subjects/data/models/user_selected_subjects/user_selected_subjects_model.dart';
import 'package:silab/features/subjects/domain/entities/subject/subject_entity.dart';
import 'package:silab/features/subjects/presentation/bloc/subject_list/subject_list_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DaftarPraktikumPage extends StatefulWidget {
  const DaftarPraktikumPage({super.key});

  @override
  State<DaftarPraktikumPage> createState() => _DaftarPraktikumPageState();
}

class _DaftarPraktikumPageState extends State<DaftarPraktikumPage> {
  var currentValue = 1;
  List<SubjectEntity> userSelectedSubjectsId = [];

  @override
  void initState() {
    context.read<SubjectListBloc>().add(GetSubjectList(semester: currentValue));
    context.read<SelectedSubjectByNimBloc>().add(GetUserSelectedSubjects());
    super.initState();
  }

  Set<String> _registeredSubjectIds(SelectedSubjectByNimState state) => {
        for (final activation in state.selectedSubjectEntity ?? const [])
          if (activation.subject_id != null) activation.subject_id!,
      };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height -
            Scaffold.of(context).appBarMaxHeight!,
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 24),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              const Text(
                'Pilihlah praktikum sesuai dengan Mata Kuliah yang anda ambil di KRS.',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDropdownHeader(),
                    _buildSubjectList(),
                    const SizedBox(height: 16),
                    _buildNextButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return CustomSmallButton(
      label: const Text(
        'Selanjutnya',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      onPressed: userSelectedSubjectsId.isNotEmpty
          ? () => context.pushNamed(
                'ringkasan-praktikum',
                extra: RingkasanDaftarPageExtra(
                  userSelectedSubjects: UserSelectedSubjectsModel(
                    userSelectedSubjectsId,
                  ),
                ),
              )
          : null,
    );
  }

  Widget _buildDropdownHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Daftar Praktikum',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        BuildDaftarPraktikumPageDropdown(
          currentValue: currentValue,
          onChanged: (value) => setState(() {
            currentValue = value!;
            context
                .read<SubjectListBloc>()
                .add(GetSubjectList(semester: value));
          }),
        ),
      ],
    );
  }

  Widget _buildSubjectList() {
    return Flexible(
      fit: FlexFit.loose,
      child: BlocConsumer<SubjectListBloc, SubjectListState>(
        listener: (context, state) {
          if (state is SubjectListFailed) {
            if (state.message == 'jwt expired') {
              context.goNamed('authentication');
            } else {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                snackBar(
                  message: state.message,
                  type: AlertType.error,
                ),
              );
            }
          }
        },
        builder: (context, state) =>
            BlocBuilder<SelectedSubjectByNimBloc, SelectedSubjectByNimState>(
          builder: (context, registrations) {
            final registeredIds = _registeredSubjectIds(registrations);
            final hasSubjects = state is! SubjectListLoading &&
                state.subjectList != null &&
                state.subjectList!.isNotEmpty;

            return Skeletonizer(
              enabled: state is SubjectListLoading ? true : false,
              enableSwitchAnimation: true,
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: hasSubjects
                      ? Border.all(
                          color: const Color(0xffBFD9EF),
                          width: 2,
                        )
                      : null,
                ),
                child: ListView.builder(
                  itemCount: hasSubjects ? state.subjectList!.length : 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: hasSubjects ? 0 : 36),
                  itemBuilder: (context, index) {
                    if (state is SubjectListFailed) {
                      return BuildDaftarPraktikumPageSubjectFailed(
                        onRetry: () => context
                            .read<SubjectListBloc>()
                            .add(GetSubjectList(semester: currentValue)),
                      );
                    }

                    if (!hasSubjects) {
                      return const BuildDaftarPraktikumPageSubjectEmpty();
                    }

                    final subject = state.subjectList![index];

                    return BuildDaftarPraktikumSubjectItem(
                      onChanged: (value) {
                        setState(() {
                          if (value!) {
                            userSelectedSubjectsId.add(subject);
                          } else {
                            userSelectedSubjectsId.remove(subject);
                          }
                        });
                      },
                      index: index,
                      state: state,
                      userSelectedSubjectsId: userSelectedSubjectsId,
                      isRegistered: registeredIds.contains(subject.id),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
