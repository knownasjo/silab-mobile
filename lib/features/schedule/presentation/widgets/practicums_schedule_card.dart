import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/features/classes/presentation/pages/class_detail_page.dart';
import 'package:silab/features/schedule/domain/entities/practicums/practicums_entity.dart';

class PracticumsScheduleCard extends StatelessWidget {
  final List<PracticumsEntity>? practicumsEntity;

  const PracticumsScheduleCard({
    super.key,
    this.practicumsEntity,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: practicumsEntity?.length ?? 1,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, idx) =>
          _buildCard(context, practicumsEntity?[idx]),
    );
  }

  Widget _buildCard(BuildContext context, PracticumsEntity? practicum) {
    final classEntity = practicum?.class_entity;
    final session = practicum?.session ?? 'Sesi Kelas';
    final room = practicum?.room;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: classEntity == null
            ? null
            : () => context.pushNamed(
                  'class',
                  pathParameters: {'id': classEntity.id!},
                  extra: ClassDetailPageExtra(classEntity: classEntity),
                ),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffBFD9EF),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffFBFBEF),
                  border: Border.all(
                    color: const Color(0xffFFBF01),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  practicum?.subject_class ?? 'X',
                  style: const TextStyle(
                    color: Color(0xffFFBF01),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      practicum?.subject_name ?? 'Mata Praktikum',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      room == null ? session : '$session · $room',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (practicum?.is_assistant == true)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffBFD9EF),
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: const Text(
                    'Asisten',
                    style: TextStyle(
                      color: Color(0xff3272CA),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              else if (classEntity != null)
                const Icon(
                  Boxicons.bx_chevron_right,
                  color: Color(0xff3272CA),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
