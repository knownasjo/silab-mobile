import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class BuildStatusMessage extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const BuildStatusMessage({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff5E6278),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (onRetry != null)
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
      ),
    );
  }
}
