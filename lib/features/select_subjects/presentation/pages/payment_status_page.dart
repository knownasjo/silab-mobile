import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/features/select_subjects/presentation/bloc/cancel_activation/cancel_activation_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/selected_subject_by_nim/selected_subject_by_nim_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_event.dart';
import 'package:silab/features/select_subjects/presentation/widgets/build_payment_status_page_content.dart';

class PaymentStatusPage extends StatefulWidget {
  const PaymentStatusPage({super.key});

  @override
  State<PaymentStatusPage> createState() => _PaymentStatusPageState();
}

class _PaymentStatusPageState extends State<PaymentStatusPage> {
  bool? isVerified = false;

  @override
  void initState() {
    context.read<SelectedSubjectByNimBloc>().add(GetUserSelectedSubjects());
    context
        .read<UserClassOptionByPaidSubjectBloc>()
        .add(GetUserClassOptionByPaidSubject());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height -
            Scaffold.of(context).appBarMaxHeight!,
        child: BlocListener<CancelActivationBloc, CancelActivationState>(
          listener: _onCancelActivation,
          child: const Padding(
            padding: EdgeInsets.only(right: 15, left: 15, top: 24, bottom: 16),
            child: BuildPaymentStatusPageContent(),
          ),
        ),
      ),
    );
  }

  void _onCancelActivation(BuildContext context, CancelActivationState state) {
    if (state is CancelActivationSucceeded) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar(
          message: state.message,
          type: AlertType.success,
        ),
      );
      context
          .read<SelectedSubjectByNimBloc>()
          .add(RefreshUserSelectedSubjects());
    }

    if (state is CancelActivationFailed) {
      if (state.message == 'jwt expired') {
        context.goNamed('authentication');
        return;
      }

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar(
          message: state.message,
          type: AlertType.error,
        ),
      );
    }
  }
}
