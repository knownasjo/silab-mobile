import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_bottom_navbar.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/core/helpers/time_formatter.dart';
import 'package:silab/features/announcement/domain/entities/announcement/announcement_entity.dart';
import 'package:silab/features/announcement/presentation/blocs/get_announcement/get_announcement_bloc.dart';
import 'package:silab/features/announcement/presentation/widgets/announcement_type_style.dart';

class PengumumanPageExtra {
  final String? title;
  final String? body;
  final String? type;
  final String? author;
  final String? createdAt;

  const PengumumanPageExtra({
    this.author,
    this.body,
    this.title,
    this.type,
    this.createdAt,
  });
}

class PengumumanPage extends StatefulWidget {
  final String? id;

  const PengumumanPage({
    super.key,
    this.id,
  });

  @override
  State<PengumumanPage> createState() => _PengumumanPageState();
}

class _PengumumanPageState extends State<PengumumanPage> {
  @override
  void initState() {
    context.read<GetAnnouncementBloc>().add(GetAnnouncement(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAnnouncementBloc, GetAnnouncementState>(
      listener: (context, state) {
        if (state is GetAnnouncementDeleted) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              snackBar(message: state.message, type: AlertType.info),
            );
          context.canPop() ? context.pop() : context.goNamed('home');
        } else if (state is GetAnnouncementFailed) {
          if (state.message == 'jwt expired') {
            context.goNamed('authentication');
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              snackBar(
                type: AlertType.error,
                message: state.message,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        return Material(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
              top: 24,
              bottom: bottomNavbarSpace,
            ),
            child: SizedBox(
              width: double.infinity,
              child: switch (state) {
                GetAnnouncementLoaded(:final announcement?) =>
                  _buildAnnouncement(context, announcement),
                GetAnnouncementFailed() => _buildFailed(context),
                _ => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xff3272CA),
                        ),
                      ),
                    ),
                  ),
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnnouncement(
      BuildContext context, AnnouncementEntity announcement) {
    final typeStyle = AnnouncementTypeStyle.of(announcement.type);
    final body = announcement.body ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: typeStyle.color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            typeStyle.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          announcement.title ?? '-',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${announcement.author ?? '-'}, ${formatPostedAt(announcement.created_at)}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: const Color(0xff1d1d1d).withOpacity(0.3),
          ),
        ),
        const SizedBox(height: 24),
        SelectableText(
          body,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () => _copyBody(context, body),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xff3272CA),
            ),
            icon: const Icon(Boxicons.bx_copy),
            label: const Text('Salin isi'),
          ),
        ),
      ],
    );
  }

  Future<void> _copyBody(BuildContext context, String body) async {
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: body));
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        snackBar(
          message: 'Isi pengumuman disalin.',
          type: AlertType.success,
        ),
      );
  }

  Widget _buildFailed(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat pengumuman.'),
            TextButton.icon(
              onPressed: () => context
                  .read<GetAnnouncementBloc>()
                  .add(GetAnnouncement(id: widget.id)),
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
}
