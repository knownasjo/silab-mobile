import 'package:flutter/material.dart';
import 'package:silab/core/helpers/day_formatter.dart';
import 'package:silab/features/select_subjects/domain/entities/user_class_option_by_paid_subject/user_class_option_by_paid_subject_entity.dart';

class ClassOptionList extends StatelessWidget {
  final List<UserClassOptionByPaidSubjectEntity> classes;
  final ValueChanged<String?> onClassChanged;
  final String? selectedClass;

  const ClassOptionList({
    super.key,
    required this.classes,
    required this.onClassChanged,
    required this.selectedClass,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: classes.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final option = classes[index];
        final quota = option.quota ?? 0;
        final registered = option.registered_students ?? 0;
        final isFull = registered >= quota;
        final textColor =
            isFull ? const Color(0xff8d8d8d) : const Color(0xff1d1d1d);

        return Container(
          margin: EdgeInsets.only(bottom: index != classes.length - 1 ? 12 : 0),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: isFull ? null : () => onClassChanged(option.class_id),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isFull
                      ? const Color(0xffe6e6e6)
                      : const Color(0xffBFD9EF),
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
                color: isFull ? const Color(0xfff6f6f6) : Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Radio<String?>(
                    value: option.class_id,
                    groupValue: selectedClass,
                    onChanged: isFull ? null : (value) => onClassChanged(value),
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    toggleable: !isFull,
                    fillColor:
                        WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.disabled)) {
                        return const Color(0xff8d8d8d).withOpacity(0.5);
                      }
                      return const Color(0xff3272CA);
                    }),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          option.subject_class!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          '${formatDay(option.day)}, ${option.session_time}',
                          style: TextStyle(fontSize: 14, color: textColor),
                        ),
                        Text(
                          '$registered/$quota',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isFull
                                ? const Color(0xffFF0000)
                                : quota - registered <= 5
                                    ? const Color(0xffFFBF01)
                                    : const Color(0xff1d1d1d),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
