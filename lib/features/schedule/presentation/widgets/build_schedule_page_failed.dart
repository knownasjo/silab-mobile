import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:silab/features/schedule/presentation/bloc/user_schedule_bloc.dart';

class BuildSchedulePageFailed extends StatelessWidget {
  const BuildSchedulePageFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Gagal memuat jadwal.'),
          TextButton.icon(
            onPressed: () =>
                context.read<UserScheduleBloc>().add(GetUserSchedule()),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xff3272CA),
            ),
            icon: const Icon(Boxicons.bx_refresh),
            label: const Text('Coba lagi'),
          ),
        ],
      ),
    );
  }
}
