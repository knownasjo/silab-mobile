import 'package:timeago/timeago.dart' as timeago;

const List<String> _monthNames = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agu',
  'Sep',
  'Okt',
  'Nov',
  'Des',
];

String _twoDigits(int value) => value.toString().padLeft(2, '0');

String formatPostedAt(String? isoTime, {DateTime? now}) {
  final parsed = isoTime == null ? null : DateTime.tryParse(isoTime);

  if (parsed == null) return '-';

  final time = parsed.toLocal();
  final clock = now ?? DateTime.now();

  if (clock.difference(time).inDays == 0) {
    timeago.setLocaleMessages('id', timeago.IdMessages());
    return timeago.format(time, locale: 'id', clock: clock);
  }

  return '${time.day} ${_monthNames[time.month - 1]} ${time.year}, '
      '${_twoDigits(time.hour)}.${_twoDigits(time.minute)}';
}
