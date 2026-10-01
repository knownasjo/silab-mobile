import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_bottom_navbar.dart';
import 'package:silab/core/common/widgets/custom_small_button.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/features/select_subjects/domain/entities/user_class_option_by_paid_subject/user_class_option_by_paid_subject_entity.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_event.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_state.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_pick_class_page_confirmation_dialog.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_pick_class_page_subject_class_option.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_status_message.dart';

class BuildPickClassPageContent extends StatefulWidget {
  const BuildPickClassPageContent({super.key});

  static const String emptyMessage = 'Tidak ada kelas yang bisa dipilih.';

  @override
  State<BuildPickClassPageContent> createState() =>
      _BuildPickClassPageContentState();
}

class _BuildPickClassPageContentState extends State<BuildPickClassPageContent> {
  final Map<String, String> selectedClasses = {};

  void onSelectedClassChanged({String? subjectName, String? selectedClass}) {
    setState(() {
      if (selectedClass == null) {
        selectedClasses.remove(subjectName);
      } else {
        selectedClasses[subjectName!] = selectedClass;
      }
    });
  }

  void _dropUnavailableChoices(
      List<UserClassOptionByPaidSubjectEntity> options) {
    final openClassIds = {
      for (final option in options)
        if ((option.registered_students ?? 0) < (option.quota ?? 0))
          option.class_id,
    };

    setState(() {
      selectedClasses
          .removeWhere((_, classId) => !openClassIds.contains(classId));
    });
  }

  void _reload(BuildContext context) {
    context
        .read<UserClassOptionByPaidSubjectBloc>()
        .add(GetUserClassOptionByPaidSubject());
  }

  void _confirm(
      BuildContext context, List<UserClassOptionByPaidSubjectEntity> options) {
    showAdaptiveDialog(
      useRootNavigator: true,
      context: context,
      builder: (context) => BuildPickClassPageConfirmationDialog(
        selectedClasses: options
            .where((option) => selectedClasses.containsValue(option.class_id))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const Text(
          'Pilih kelas yang anda inginkan. Sesuaikan dengan jadwal anda!',
        ),
        const SizedBox(height: 20),
        BlocConsumer<UserClassOptionByPaidSubjectBloc,
            UserClassOptionByPaidSubjectState>(
          listener: (context, state) {
            if (state is UserClassOptionByPaidSubjectLoaded) {
              _dropUnavailableChoices(
                  state.userClassOptionByPaidSubjectEntity ?? []);
            }

            if (state is UserClassOptionByPaidSubjectFailed) {
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
          builder: (context, state) {
            if (state is UserClassOptionByPaidSubjectLoaded) {
              final options = state.userClassOptionByPaidSubjectEntity ?? [];

              if (options.isEmpty) {
                return const BuildStatusMessage(
                  message: BuildPickClassPageContent.emptyMessage,
                );
              }

              final Map<String?, List<UserClassOptionByPaidSubjectEntity>>
                  groupedClasses =
                  groupBy(options, ((classes) => classes.subject_name));

              return Column(
                children: [
                  BuildPickClassPageSubjectClassOption(
                    groupedClasses: groupedClasses,
                    selectedClasses: selectedClasses,
                    onClassChanged: ({selectedClass, subjectName}) =>
                        onSelectedClassChanged(
                      subjectName: subjectName,
                      selectedClass: selectedClass,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomSmallButton(
                        label: const Text(
                          'Simpan',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: selectedClasses.isNotEmpty
                            ? () => _confirm(context, options)
                            : null,
                      ),
                    ],
                  ),
                ],
              );
            }

            if (state is UserClassOptionByPaidSubjectFailed) {
              return BuildStatusMessage(
                message: 'Gagal memuat kelas.',
                onRetry: () => _reload(context),
              );
            }

            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xff3272CA),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: bottomNavbarSpace),
      ],
    );
  }
}
