import 'package:flutter/material.dart';
import 'package:silab/core/common/widgets/custom_bottom_navbar.dart';
import 'package:silab/features/schedule/presentation/bloc/user_schedule_bloc.dart';
import 'package:silab/features/schedule/presentation/widgets/build_schedule_page_empty.dart';
import 'package:silab/features/schedule/presentation/widgets/build_schedule_page_schedule_list.dart';
import 'package:silab/features/schedule/presentation/widgets/build_scheulde_page_loading.dart';

class BuildSchedulePageSuccess extends StatelessWidget {
  final UserScheduleState state;

  const BuildSchedulePageSuccess({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final hasSchedules = state.schedules != null && state.schedules!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: hasSchedules ? bottomNavbarSpace : 0),
        itemCount: hasSchedules ? state.schedules!.length : 1,
        itemBuilder: (context, index) => state is UserScheduleLoading
            ? const BuildScheuldePageLoading()
            : hasSchedules
                ? BuildSchedulePageScheduleList(state: state, index: index)
                : const BuildSchedulePageEmpty(),
      ),
    );
  }
}
