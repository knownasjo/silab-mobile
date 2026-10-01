import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:silab/core/helpers/initials.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_loading_indicator.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/features/classes/domain/entities/classmate/classmate_entity.dart';
import 'package:silab/features/classes/domain/entities/meetings/meetings_entity.dart';
import 'package:silab/features/classes/presentation/bloc/classmates/classmates_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_meetings/user_meetings_bloc.dart';
import 'package:silab/features/classes/presentation/pages/qr_scan_page.dart';

class ClassDetailTabView extends StatefulWidget {
  final String? classId;

  const ClassDetailTabView({
    super.key,
    this.classId,
  });

  @override
  State<ClassDetailTabView> createState() => _ClassDetailPageTabiewState();
}

class _ClassDetailPageTabiewState extends State<ClassDetailTabView> {
  int pageLocation = 0;

  List<String> pageItems = ['Presensi', 'Classmates'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPageSelector(),
        const SizedBox(height: 24),
        _buildPageContent(pageLocation),
      ],
    );
  }

  Widget _buildPageSelector() {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: pageItems.length,
        itemBuilder: (context, index) => InkWell(
          borderRadius: BorderRadius.circular(90),
          splashColor: Colors.transparent,
          onTap: () => setState(() {
            pageLocation = index;
          }),
          child: _buildPageSelectorItem(index),
        ),
      ),
    );
  }

  Widget _buildPageSelectorItem(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: pageLocation != index
            ? const Color(0xffF4F4F9)
            : const Color(0xff3272CA),
        border: pageLocation != index
            ? Border.all(
                color: const Color(0xff1D1D1D).withOpacity(0.5),
                width: 0.5,
                strokeAlign: BorderSide.strokeAlignInside,
              )
            : null,
      ),
      child: Center(
        child: Text(
          pageItems[index],
          style: TextStyle(
            color: pageLocation != index
                ? const Color(0xff1D1D1D).withOpacity(0.7)
                : const Color(0xffF4F4F9),
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(int index) => switch (pageItems[index]) {
        'Classmates' => _buildClassmates(),
        _ => _buildMeetings(),
      };

  Widget _buildMeetings() {
    return BlocBuilder<UserMeetingsBloc, UserMeetingsState>(
      builder: (context, state) {
        if (state is UserMeetingsLoading) {
          return _buildTabLoading();
        }

        if (state is UserMeetingsFailed) {
          return _buildTabMessage(
            state.message ?? 'Gagal memuat daftar pertemuan.',
            onRetry: () => context
                .read<UserMeetingsBloc>()
                .add(GetUserMeetings(classId: widget.classId)),
          );
        }

        final meetings = state.meetingsData ?? const <MeetingsEntity>[];

        if (state is UserMeetingsLoaded && meetings.isEmpty) {
          return _buildTabMessage('Belum ada pertemuan di kelas ini.');
        }

        return _buildMeetingList(meetings.reversed.toList());
      },
    );
  }

  Widget _buildClassmates() {
    return BlocConsumer<ClassmatesBloc, ClassmatesState>(
      listener: (context, state) {
        if (state is ClassmatesFailed && state.message == 'jwt expired') {
          context.goNamed('authentication');
        }
      },
      builder: (context, state) {
        if (state is ClassmatesLoading) {
          return _buildTabLoading();
        }

        if (state is ClassmatesFailed) {
          return _buildTabMessage(
            state.message ?? 'Gagal memuat daftar teman sekelas.',
            onRetry: () => context
                .read<ClassmatesBloc>()
                .add(GetClassmates(classId: widget.classId)),
          );
        }

        final classmates = state.classmates ?? const <ClassmateEntity>[];

        if (state is ClassmatesLoaded && classmates.isEmpty) {
          return _buildTabMessage('Belum ada peserta di kelas ini.');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (classmates.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 12),
                child: Text(
                  '${classmates.length} mahasiswa terdaftar',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xff1D1D1D).withOpacity(0.7),
                  ),
                ),
              ),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: classmates.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, idx) =>
                  _buildClassmateItem(classmates[idx]),
            ),
          ],
        );
      },
    );
  }

  Widget _buildClassmateItem(ClassmateEntity classmate) {
    final name = classmate.name ?? '-';
    final isMe = classmate.is_me == true;

    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: const Color(0xffF4F4F9),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: isMe ? const Color(0xff3272CA) : Colors.white,
            child: Text(
              nameInitials(name),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isMe ? Colors.white : const Color(0xff3272CA),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(name, overflow: TextOverflow.ellipsis),
          ),
          if (isMe)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                'Anda',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xff3272CA),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabLoading() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Center(child: CustomLoadingIndicator()),
    );
  }

  Widget _buildTabMessage(String message, {VoidCallback? onRetry}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xff1D1D1D).withOpacity(0.7),
              ),
            ),
            if (onRetry != null)
              TextButton.icon(
                onPressed: onRetry,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xff3272CA),
                ),
                icon: const Icon(Boxicons.bx_refresh),
                label: const Text('Coba lagi'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeetingList(List<MeetingsEntity> meetingList) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: meetingList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, idx) {
        final meeting = meetingList[idx];

        return Container(
          width: double.infinity,
          height: 56,
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: const Color(0xffF4F4F9),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: Text(
                    meeting.meeting_name ?? '-',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              _canScan(meeting)
                  ? _buildScanButton(meeting)
                  : _buildStatusIcon(meeting),
            ],
          ),
        );
      },
    );
  }

  bool _canScan(MeetingsEntity meeting) =>
      meeting.is_open == true &&
      meeting.attendanceStatus == AttendanceStatus.belumPresensi;

  Widget _buildScanButton(MeetingsEntity meeting) {
    return Material(
      color: const Color(0xff3272CA),
      shape: const StadiumBorder(),
      child: InkWell(
        onTap: () => _onMeetingTapped(meeting),
        customBorder: const StadiumBorder(),
        child: const SizedBox(
          height: 40,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Boxicons.bx_qr_scan, color: Colors.white, size: 18),
                SizedBox(width: 6),
                Text(
                  'Scan QR',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(MeetingsEntity meeting) {
    final style = _statusStyles[meeting.attendanceStatus]!;

    return InkWell(
      onTap: () => _onMeetingTapped(meeting),
      borderRadius: BorderRadius.circular(50),
      splashColor: const Color(0xffBFD9EF),
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: style.border == null
              ? null
              : Border.all(color: style.border!, width: 2),
          color: style.background,
        ),
        child: Image.asset(
          'assets/image/${style.icon}',
          scale: 2,
        ),
      ),
    );
  }

  void _onMeetingTapped(MeetingsEntity meeting) {
    final String? reason;
    if (meeting.attendanceStatus != AttendanceStatus.belumPresensi) {
      reason = 'Presensi pertemuan ini sudah tercatat.';
    } else if (meeting.is_open != true) {
      reason = 'Sesi presensi sedang tidak dibuka.';
    } else {
      reason = null;
    }

    if (reason != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar(message: reason, type: AlertType.info));
      return;
    }

    context.pushNamed(
      'qr-scan',
      extra: QrScanPageExtra(meetingId: meeting.id, classId: widget.classId),
    );
  }
}

typedef _StatusStyle = ({String icon, Color? border, Color background});

const Map<AttendanceStatus, _StatusStyle> _statusStyles = {
  AttendanceStatus.hadir: (
    icon: 'presence.png',
    border: Color(0xff50CD89),
    background: Color(0xffE8FFF3),
  ),
  AttendanceStatus.tidakHadir: (
    icon: 'absence.png',
    border: Color(0xffF1416C),
    background: Color(0xffFFF5F8),
  ),
  AttendanceStatus.belumPresensi: (
    icon: 'none.png',
    border: null,
    background: Colors.transparent,
  ),
};
