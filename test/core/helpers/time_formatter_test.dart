import 'package:flutter_test/flutter_test.dart';
import 'package:silab/core/helpers/time_formatter.dart';

void main() {
  final now = DateTime(2026, 10, 1, 10, 0);
  String iso(DateTime local) => local.toUtc().toIso8601String();

  test('kurang dari sehari: waktu relatif berbahasa Indonesia', () {
    expect(
      formatPostedAt(iso(now.subtract(const Duration(seconds: 20))), now: now),
      'kurang dari semenit yang lalu',
    );
    expect(
      formatPostedAt(iso(now.subtract(const Duration(minutes: 5))), now: now),
      '5 menit yang lalu',
    );
    expect(
      formatPostedAt(iso(now.subtract(const Duration(hours: 3))), now: now),
      '3 jam yang lalu',
    );
  });

  test('sehari atau lebih: tanggal, bulan singkat Indonesia, dan jam', () {
    expect(formatPostedAt(iso(DateTime(2026, 9, 29, 6, 4)), now: now),
        '29 Sep 2026, 06.04');
    expect(formatPostedAt(iso(DateTime(2026, 5, 2, 18, 30)), now: now),
        '2 Mei 2026, 18.30');
    expect(formatPostedAt(iso(DateTime(2025, 8, 17, 0, 0)), now: now),
        '17 Agu 2025, 00.00');
    expect(formatPostedAt(iso(DateTime(2026, 12, 31, 23, 59)), now: now),
        '31 Des 2026, 23.59');
  });

  test('waktu dari server (UTC) ditampilkan dalam waktu HP', () {
    final local = DateTime(2026, 9, 30, 9, 0);
    expect(formatPostedAt(local.toUtc().toIso8601String(), now: now),
        '30 Sep 2026, 09.00');
  });

  test('kosong atau rusak: tanda strip', () {
    expect(formatPostedAt(null, now: now), '-');
    expect(formatPostedAt('bukan tanggal', now: now), '-');
  });
}
