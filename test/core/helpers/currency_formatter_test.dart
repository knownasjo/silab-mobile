import 'package:flutter_test/flutter_test.dart';
import 'package:silab/core/helpers/currency_formatter.dart';

void main() {
  test('rupiah dengan titik ribuan tanpa desimal', () {
    expect(formatRupiah(0), 'Rp0');
    expect(formatRupiah(5000), 'Rp5.000');
    expect(formatRupiah(3 * practicumFeePerSubject), 'Rp15.000');
    expect(formatRupiah(1250000), 'Rp1.250.000');
  });
}
