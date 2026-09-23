import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/coming_soon.dart';
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
  PageController controller = PageController();

  List<String> pageItems = ['Presensi', 'Modul', 'Classmates'];

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.shortestSide,
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPageSelector(),
          const SizedBox(height: 24),
          Flexible(
            fit: FlexFit.loose,
            child: PageView.builder(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) => setState(() {
                pageLocation = value;
              }),
              itemCount: pageItems.length,
              itemBuilder: (context, index) => _buildPageContent(index),
            ),
          )
        ],
      ),
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
          onTap: () => controller.jumpToPage(index),
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
        'Modul' => const ComingSoon(feature: 'Modul'),
        'Classmates' => _buildClassmates(),
        _ => _buildMeetings(),
      };

  Widget _buildMeetings() {
    return BlocBuilder<UserMeetingsBloc, UserMeetingsState>(
      builder: (context, state) {
        List<MeetingsEntity> meetingList;
        if (state is UserMeetingsLoaded && state.meetingsData != null) {
          meetingList = state.meetingsData!.reversed.toList();

          return _buildMeetingList(meetingList);
        } else {
          return const SizedBox();
        }
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
          return const Center(child: CustomLoadingIndicator());
        }

        if (state is ClassmatesFailed) {
          return _buildTabMessage(
              state.message ?? 'Gagal memuat daftar teman sekelas.');
        }

        final classmates = state.classmates ?? const <ClassmateEntity>[];

        if (state is ClassmatesLoaded && classmates.isEmpty) {
          return _buildTabMessage('Belum ada peserta di kelas ini.');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: classmates.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, idx) =>
                    _buildClassmateItem(classmates[idx]),
              ),
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
              name.isEmpty ? '?' : name[0].toUpperCase(),
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

  Widget _buildTabMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xff1D1D1D).withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Widget _buildMeetingList(List<MeetingsEntity> meetingList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: meetingList.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, idx) {
        final meeting = meetingList[idx];
        final style = _statusStyles[meeting.attendanceStatus]!;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16),
                child: Text(meeting.meeting_name!),
              ),
              InkWell(
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
              )
            ],
          ),
        );
      },
    );
  }

  void _onMeetingTapped(MeetingsEntity meeting) {
    final String? reason;
    if (meeting.attendanceStatus != AttendanceStatus.belumPresensi) {
      reason = 'Presensi pertemuan ini sudah tercatat.';
    } else if (meeting.is_open != true) {
      reason = 'Sesi presensi belum dibuka oleh asisten.';
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
