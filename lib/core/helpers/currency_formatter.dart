import 'package:intl/intl.dart';

const int practicumFeePerSubject = 5000;

final localedPrice = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp ',
  decimalDigits: 0,
);

String formatRupiah(int amount) =>
    'Rp${NumberFormat.decimalPattern('id_ID').format(amount)}';
