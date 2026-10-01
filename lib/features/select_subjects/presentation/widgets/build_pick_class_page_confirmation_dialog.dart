import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/core/helpers/day_formatter.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';
import 'package:silab/features/select_subjects/domain/entities/user_class_option_by_paid_subject/user_class_option_by_paid_subject_entity.dart';
import 'package:silab/features/select_subjects/presentation/bloc/add_selected_class/add_selected_class_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/selected_subject_by_nim/selected_subject_by_nim_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_event.dart';

class BuildPickClassPageConfirmationDialog extends StatelessWidget {
  final List<UserClassOptionByPaidSubjectEntity> selectedClasses;

  const BuildPickClassPageConfirmationDialog({
    super.key,
    required this.selectedClasses,
  });

  static const String finalChoiceWarning =
      'Kelas yang sudah disimpan tidak bisa diganti sendiri. Hubungi laboran jika perlu pindah.';

  void _save(BuildContext context) {
    context.read<AddSelectedClassBloc>().add(
          AddSelectedClass(
            selectedClass:
                selectedClasses.map((option) => option.class_id!).toList(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddSelectedClassBloc, AddSelectedClassState>(
      listener: (context, state) {
        if (state is AddSelectedClassSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          showDialog(
            context: context,
            useRootNavigator: true,
            barrierDismissible: false,
            builder: (context) => _buildSuccessDialog(context),
          );
        }
        if (state is AddSelectedClassFailed) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
              message: state.message,
              type: AlertType.error,
            ),
          );
          context
              .read<UserClassOptionByPaidSubjectBloc>()
              .add(RefreshUserClassOptionByPaidSubject());
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
      builder: (context, state) {
        final isSaving = state is AddSelectedClassLoading;

        return PopScope(
          canPop: !isSaving,
          child: AlertDialog(
            backgroundColor: const Color(0xfff4f4f9),
            scrollable: true,
            title: const Text('Simpan Pilihan Kelas'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final option in selectedClasses)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.subject_name ?? '-',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Kelas ${option.subject_class} · ${formatDay(option.day)}, ${option.session_time}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  finalChoiceWarning,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xff1d1d1d).withOpacity(0.6),
                  ),
                ),
              ],
            ),
            actions: [
              Opacity(
                opacity: isSaving ? 0.5 : 1,
                child: InkWell(
                  onTap: isSaving
                      ? null
                      : () => Navigator.of(context, rootNavigator: true).pop(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffFF0000),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFFF5F8),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: isSaving ? null : () => _save(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffBFD9EF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isSaving ? 'Menyimpan...' : 'Simpan',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            alignment: Alignment.center,
            icon: SizedBox(
              height: 24,
              width: 24,
              child: Image.asset(
                'assets/image/info.png',
                scale: 2,
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
          ),
        );
      },
    );
  }

  void _finish(BuildContext context) {
    context.read<UserRegisteredClassBloc>().add(GetUserRegisteredClass());
    context
        .read<UserClassOptionByPaidSubjectBloc>()
        .add(GetUserClassOptionByPaidSubject());
    context.read<SelectedSubjectByNimBloc>().add(RefreshUserSelectedSubjects());
    final router = GoRouter.of(context);
    Navigator.of(context, rootNavigator: true).pop();
    router.canPop() ? router.pop() : router.goNamed('home');
  }

  Widget _buildSuccessDialog(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _finish(context);
      },
      child: AlertDialog(
        backgroundColor: const Color(0xffE8FFF3),
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        icon: SizedBox(
          width: 65,
          height: 65,
          child: Image.asset(
            'assets/image/checkmark-green.png',
            scale: 2,
          ),
        ),
        title: const Text(
          'Berhasil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Anda sudah terdaftar di kelas praktikum',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xff1d1d1d).withOpacity(0.6),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => _finish(context),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              backgroundColor: const Color(0xffBFD9EF),
              foregroundColor: const Color(0xff3272CA),
            ),
            child: const Text(
              'OK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
