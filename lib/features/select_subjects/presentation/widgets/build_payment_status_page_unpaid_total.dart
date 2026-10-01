import 'package:flutter/material.dart';
import 'package:silab/core/helpers/currency_formatter.dart';
import 'package:silab/features/select_subjects/domain/entities/selected_subject/selected_subject_entity.dart';

class BuildPaymentStatusPageUnpaidTotal extends StatelessWidget {
  final List<SelectedSubjectEntity> activations;

  const BuildPaymentStatusPageUnpaidTotal({
    super.key,
    required this.activations,
  });

  @override
  Widget build(BuildContext context) {
    final unpaid =
        activations.where((activation) => activation.status != true).length;

    if (unpaid == 0) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xffFBFBEF),
        border: Border.all(color: const Color(0xffFFBF01)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Belum dibayar: $unpaid mata kuliah',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Total: ${formatRupiah(unpaid * practicumFeePerSubject)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
