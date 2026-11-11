import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/features/announcement/domain/entities/announcement/announcement_entity.dart';
import 'package:silab/features/announcement/presentation/blocs/get_all_announcements/get_all_announcements_bloc.dart';
import 'package:silab/features/announcement/presentation/widgets/build_announcement_failed.dart';
import 'package:silab/features/announcement/presentation/widgets/build_announcement_success.dart';
import 'package:silab/features/home/presentation/widgets/home_load_error_snackbar.dart';

class AnnouncementCarousel extends StatefulWidget {
  const AnnouncementCarousel({super.key});

  @override
  State<AnnouncementCarousel> createState() => _AnnouncementCarouselState();
}

class _AnnouncementCarouselState extends State<AnnouncementCarousel> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllAnnouncementsBloc, GetAllAnnouncementsState>(
      listener: (context, state) {
        if (state is GetAllAnnouncementsLoaded) {
          final lastPage = max(0, (state.announcements?.length ?? 0) - 1);

          if (currentPage > lastPage) {
            setState(() {
              currentPage = lastPage;
            });
          }
        }

        if (state is GetAllAnnouncementsFailed) {
          if (state.message == 'jwt expired') {
            context.goNamed('authentication');
          } else {
            showHomeLoadError(context, state.message);
          }
        }
      },
      builder: (context, state) {
        final List<AnnouncementEntity> announcements =
            (state is GetAllAnnouncementsLoaded && state.announcements != null)
            ? state.announcements!
            : [];

        if (state is GetAllAnnouncementsFailed) {
          return const BuildAnnouncementFailed();
        }
        return BuildAnnouncementSuccess(
          announcements: announcements,
          currentPage: currentPage,
          onPageChanged: (value) => setState(() {
            currentPage = value;
          }),
          state: state,
        );
      },
    );
  }
}
