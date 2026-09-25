import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/entities/class/class_entity.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';

class RegisteredClassGuard extends StatelessWidget {
  final ClassEntity classEntity;
  final Widget Function(BuildContext context, ClassEntity latest) builder;

  const RegisteredClassGuard({
    super.key,
    required this.classEntity,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRegisteredClassBloc, UserRegisteredClassState>(
      builder: (context, state) {
        final registered =
            state is UserRegisteredClassLoaded ? state.registeredClasses : null;
        final latest =
            registered?.where((item) => item.id == classEntity.id).firstOrNull;

        if (registered != null && latest == null) {
          return const _LeftClassNotice();
        }

        return builder(context, latest ?? classEntity);
      },
    );
  }
}

class _LeftClassNotice extends StatelessWidget {
  const _LeftClassNotice();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Anda sudah tidak terdaftar di kelas ini.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Kelasnya dihapus atau Anda dipindah ke kelas lain oleh laboran. Lihat kelas terbaru di Beranda.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: const Color(0xff1d1d1d).withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.goNamed('home'),
              child: const Text(
                'Kembali ke Beranda',
                style: TextStyle(
                  color: Color(0xff3272CA),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
