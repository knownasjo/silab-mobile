import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/core/common/entities/class/class_entity.dart';
import 'package:silab/features/classes/presentation/bloc/classmates/classmates_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_meetings/user_meetings_bloc.dart';
import 'package:silab/features/classes/presentation/widgets/class_card.dart';
import 'package:silab/features/classes/presentation/widgets/class_details_tabview.dart';

class ClassDetailPageExtra {
  final ClassEntity classEntity;

  const ClassDetailPageExtra({required this.classEntity});
}

class ClassDetailPage extends StatefulWidget {
  final ClassDetailPageExtra classDetailPageExtra;

  const ClassDetailPage({super.key, required this.classDetailPageExtra});

  @override
  State<ClassDetailPage> createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  @override
  void initState() {
    _loadClassData();
    super.initState();
  }

  void _loadClassData() {
    final classId = widget.classDetailPageExtra.classEntity.id;

    context.read<UserMeetingsBloc>().add(GetUserMeetings(classId: classId));
    context.read<ClassmatesBloc>().add(GetClassmates(classId: classId));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: RefreshIndicator(
            color: const Color(0xff3272CA),
            backgroundColor: Colors.white,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async => _loadClassData(),
            child: ListView(
              shrinkWrap: true,
              children: [
                ClassCard(classEntity: widget.classDetailPageExtra.classEntity),
                const SizedBox(height: 24),
                ClassDetailTabView(
                  classId: widget.classDetailPageExtra.classEntity.id,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
