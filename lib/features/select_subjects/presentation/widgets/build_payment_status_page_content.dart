import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/features/select_subjects/presentation/bloc/selected_subject_by_nim/selected_subject_by_nim_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_event.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_payment_status_page_message.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_payment_status_page_pick_class_button.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_payment_status_page_subject_list.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_payment_status_page_unpaid_total.dart';

class BuildPaymentStatusPageContent extends StatelessWidget {
  const BuildPaymentStatusPageContent({super.key});

  static const String emptyMessage =
      'Belum ada pendaftaran. Daftar praktikum lewat pengumuman Pendaftaran Praktikum di Beranda.';

  void _reload(BuildContext context) {
    context.read<SelectedSubjectByNimBloc>().add(GetUserSelectedSubjects());
    context
        .read<UserClassOptionByPaidSubjectBloc>()
        .add(GetUserClassOptionByPaidSubject());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _reload(context),
      color: const Color(0xff3272CA),
      backgroundColor: Colors.white,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: ListView(
        shrinkWrap: true,
        children: [
          const Text(
            'Selesaikan pembayaran anda. Status pembayaran anda akan diubah secara otomatis.',
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
                BlocBuilder<SelectedSubjectByNimBloc,
                    SelectedSubjectByNimState>(
                  builder: (context, state) =>
                      state is SelectedSubjectByNimLoaded
                          ? BuildPaymentStatusPageUnpaidTotal(
                              activations: state.selectedSubjectEntity ?? [],
                            )
                          : const SizedBox.shrink(),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Mata Kuliah Didaftarkan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                BlocConsumer<SelectedSubjectByNimBloc,
                    SelectedSubjectByNimState>(
                  listener: (context, state) {
                    if (state is SelectedSubjectByNimFailed) {
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
                    if (state is SelectedSubjectByNimLoaded) {
                      if (state.selectedSubjectEntity?.isEmpty ?? true) {
                        return const BuildPaymentStatusPageMessage(
                          message: emptyMessage,
                        );
                      }

                      return BuildPaymentStatusPageSubjectList(
                        state: state,
                      );
                    }

                    if (state is SelectedSubjectByNimFailed) {
                      return BuildPaymentStatusPageMessage(
                        message: 'Gagal memuat pendaftaran.',
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
                const SizedBox(height: 24),
                const BuildPaymentStatusPagePickClassButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
