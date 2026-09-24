import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/core/helpers/day_formatter.dart';
import 'package:silab/features/user_details/domain/entities/assisted_class/assisted_class_entity.dart';
import 'package:silab/features/user_details/presentation/bloc/assisted_classes/assisted_classes_bloc.dart';

class AssistedClassesSection extends StatelessWidget {
  const AssistedClassesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssistedClassesBloc, AssistedClassesState>(
      builder: (context, state) {
        if (state is! AssistedClassesLoaded || state.classes.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.maxFinite,
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xffF4F4F9),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Asisten Praktikum',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff1D1D1D),
                ),
              ),
              const SizedBox(height: 12),
              ...state.classes.map(_buildClass),
              const SizedBox(height: 4),
              const Text(
                'Kelola kelas lewat web SILAB.',
                style: TextStyle(fontSize: 12, color: Color(0x991D1D1D)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildClass(AssistedClassEntity assistedClass) {
    final time = [assistedClass.startAt, assistedClass.endAt]
        .whereType<String>()
        .join(' - ');
    final schedule = [
      formatDay(assistedClass.day),
      if (time.isNotEmpty) time,
      if (assistedClass.room != null) assistedClass.room!,
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 36,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: const Color(0xff3272CA),
              borderRadius: BorderRadius.circular(90),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${assistedClass.subjectName} — Kelas ${assistedClass.name}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1D1D1D),
                  ),
                ),
                Text(
                  schedule,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0x991D1D1D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
