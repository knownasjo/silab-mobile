const Map<String, String> _dayNames = {
  'MONDAY': 'Senin',
  'TUESDAY': 'Selasa',
  'WEDNESDAY': 'Rabu',
  'THURSDAY': 'Kamis',
  'FRIDAY': 'Jumat',
  'SATURDAY': 'Sabtu',
  'SUNDAY': 'Minggu',
};

/// Urutan hari sesuai kalender, untuk mengurutkan jadwal.
const List<String> weekdayOrder = [
  'MONDAY',
  'TUESDAY',
  'WEDNESDAY',
  'THURSDAY',
  'FRIDAY',
  'SATURDAY',
  'SUNDAY',
];

/// Backend mengirim hari sebagai enum bahasa Inggris (MONDAY, ...).
String formatDay(String? day) => _dayNames[day] ?? day ?? '-';
