import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  final String feature;

  const ComingSoon({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 240,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffF4F4F9),
              ),
              child: const Icon(
                Icons.hourglass_top_rounded,
                color: Color(0xff3272CA),
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Segera Hadir',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Fitur $feature sedang disiapkan dan akan tersedia di versi '
              'berikutnya.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xff1D1D1D).withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
