import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/features/authentication/presentation/bloc/authentication_bloc.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  static const Color _red = Color(0xffF1416C);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showAdaptiveDialog(
        context: context,
        useRootNavigator: true,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: const Color(0xfff4f4f9),
          title: const Text(
            'Keluar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('Apakah anda yakin ingin keluar dari akun ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<AuthenticationBloc>().add(UserLogout());
              },
              child: const Text('Keluar', style: TextStyle(color: _red)),
            ),
          ],
        ),
      ),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: const Row(
          children: [
            Icon(Icons.logout, color: _red, size: 20),
            SizedBox(width: 8),
            Text(
              'Keluar',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
