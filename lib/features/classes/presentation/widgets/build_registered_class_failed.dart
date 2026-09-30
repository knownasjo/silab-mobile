import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';

class BuildRegisteredClassFailed extends StatelessWidget {
  const BuildRegisteredClassFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat kelas.'),
            TextButton.icon(
              onPressed: () => context
                  .read<UserRegisteredClassBloc>()
                  .add(GetUserRegisteredClass()),
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
