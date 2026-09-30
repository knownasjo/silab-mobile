import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/features/select_subjects/domain/entities/selected_subject/selected_subject_entity.dart';
import 'package:silab/features/select_subjects/presentation/bloc/cancel_activation/cancel_activation_bloc.dart';

class BuildPaymentStatusPageCancelButton extends StatelessWidget {
  final SelectedSubjectEntity activation;

  const BuildPaymentStatusPageCancelButton({
    super.key,
    required this.activation,
  });

  String get _subjectName =>
      activation.subjects
          ?.map((subject) => subject.subject_name)
          .whereType<String>()
          .join(', ') ??
      '';

  Future<void> _confirm(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: _buildDialog,
    );

    if (confirmed == true && context.mounted) {
      context
          .read<CancelActivationBloc>()
          .add(CancelActivation(activation.activation_id!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CancelActivationBloc, CancelActivationState>(
      builder: (context, state) {
        final submittingId =
            state is CancelActivationSubmitting ? state.activationId : null;

        return TextButton(
          onPressed: submittingId != null || activation.activation_id == null
              ? null
              : () => _confirm(context),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xffFE2F60),
          ),
          child: Text(
            submittingId == activation.activation_id
                ? 'Membatalkan...'
                : 'Batalkan pendaftaran',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialog(BuildContext dialogContext) {
    return AlertDialog(
      backgroundColor: const Color(0xfff4f4f9),
      title: const Text(
        'Batalkan Pendaftaran',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Pendaftaran $_subjectName akan dibatalkan. Anda bisa mendaftarkannya lagi nanti.',
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      actions: [
        InkWell(
          onTap: () => Navigator.of(dialogContext).pop(false),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffBFD9EF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Kembali',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff3272CA),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => Navigator.of(dialogContext).pop(true),
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
              'Ya, batalkan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xffFFF5F8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
