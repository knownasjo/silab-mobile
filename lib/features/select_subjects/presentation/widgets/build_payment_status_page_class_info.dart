import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:silab/core/helpers/day_formatter.dart';
import 'package:silab/features/select_subjects/domain/entities/selected_subject/selected_subject_entity.dart';

class BuildPaymentStatusPageClassInfo extends StatelessWidget {
  final SelectedSubjectEntity activation;

  const BuildPaymentStatusPageClassInfo({
    super.key,
    required this.activation,
  });

  String get _label {
    final registered = activation.registeredClass;

    if (registered != null) {
      final detail = activation.availableClasses
          ?.firstWhereOrNull((option) => option.id == registered.id);

      return detail == null
          ? '${registered.name}'
          : '${registered.name} · ${formatDay(detail.day)}, ${detail.sessionTime}';
    }

    if (activation.status != true) return 'bisa dipilih setelah lunas';

    if (activation.availableClasses?.isEmpty ?? true) return 'belum tersedia';

    return 'belum dipilih';
  }

  @override
  Widget build(BuildContext context) {
    final hasClass = activation.registeredClass != null;

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Text(
        'Kelas: $_label',
        style: TextStyle(
          fontSize: 13,
          fontWeight: hasClass ? FontWeight.w600 : FontWeight.normal,
          color: hasClass
              ? const Color(0xff3272CA)
              : const Color(0xff1d1d1d).withOpacity(0.6),
        ),
      ),
    );
  }
}
