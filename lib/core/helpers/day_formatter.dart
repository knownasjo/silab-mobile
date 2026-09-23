const Map<String, String> _dayNames = {
  'MONDAY': 'Senin',
  'TUESDAY': 'Selasa',
  'WEDNESDAY': 'Rabu',
  'THURSDAY': 'Kamis',
  'FRIDAY': 'Jumat',
  'SATURDAY': 'Sabtu',
  'SUNDAY': 'Minggu',
};

const List<String> weekdayOrder = [
  'MONDAY',
  'TUESDAY',
  'WEDNESDAY',
  'THURSDAY',
  'FRIDAY',
  'SATURDAY',
  'SUNDAY',
];

String formatDay(String? day) => _dayNames[day] ?? day ?? '-';
