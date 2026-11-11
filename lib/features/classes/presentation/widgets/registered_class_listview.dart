import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';
import 'package:silab/features/classes/presentation/widgets/build_registered_class_failed.dart';
import 'package:silab/features/classes/presentation/widgets/build_registered_class_success.dart';
import 'package:silab/features/home/presentation/widgets/home_load_error_snackbar.dart';

class RegisteredClassListView extends StatelessWidget {
  const RegisteredClassListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserRegisteredClassBloc, UserRegisteredClassState>(
      listener: (context, state) {
        if (state is UserRegisteredClassFailed) {
          if (state.message == 'jwt expired') {
            context.goNamed('authentication');
          } else {
            showHomeLoadError(context, state.message);
          }
        }
      },
      builder: (context, state) {
        if (state is UserRegisteredClassFailed) {
          return const BuildRegisteredClassFailed();
        }
        return BuildRegisteredClassSuccess(state: state);
      },
    );
  }
}
