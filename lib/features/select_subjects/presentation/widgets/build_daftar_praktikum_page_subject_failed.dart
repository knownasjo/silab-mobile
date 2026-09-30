import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class BuildDaftarPraktikumPageSubjectFailed extends StatelessWidget {
  final VoidCallback onRetry;

  const BuildDaftarPraktikumPageSubjectFailed({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Gagal memuat mata kuliah.',
            style: TextStyle(
              color: Color(0xff5E6278),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
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
    );
  }
}
