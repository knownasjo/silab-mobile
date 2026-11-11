import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/features/announcement/presentation/blocs/get_all_announcements/get_all_announcements_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_event.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_state.dart';
import 'package:silab/features/user_details/presentation/bloc/user_details_bloc.dart';

void showHomeLoadError(BuildContext context, String? message) {
  final userDetails = context.read<UserDetailsBloc>();
  final announcements = context.read<GetAllAnnouncementsBloc>();
  final registeredClasses = context.read<UserRegisteredClassBloc>();
  final classOptions = context.read<UserClassOptionByPaidSubjectBloc>();

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    snackBar(
      message: message,
      type: AlertType.error,
      actionLabel: 'Ulangi',
      action: () {
        if (userDetails.state is UserDetailFailed) {
          userDetails.add(GetUserDetails());
        }
        if (announcements.state is GetAllAnnouncementsFailed) {
          announcements.add(GetAllAnnouncements());
        }
        if (registeredClasses.state is UserRegisteredClassFailed) {
          registeredClasses.add(GetUserRegisteredClass());
        }
        if (classOptions.state is UserClassOptionByPaidSubjectFailed) {
          classOptions.add(GetUserClassOptionByPaidSubject());
        }
      },
    ),
  );
}
